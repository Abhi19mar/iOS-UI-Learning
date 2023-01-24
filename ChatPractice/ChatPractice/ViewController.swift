//
//  ViewController.swift
//  ChatPractice
//
//  Created by Abhishek Goel on 20/12/22.
//

import UIKit
import Foundation
import RealmSwift
import Combine
import Starscream

struct ChatMessageDto: Codable {
    let user: String
    let msg: String
    
    init(user: String, msg: String) {
        self.user = user
        self.msg = msg
    }
}

enum SocketState {
    case open
    case close
}

enum SocketConnectionState {
    case disconnected
    case connecting
    case connected
}

enum WebSocketError: Error {
    case invalidUrl
    case notConnected
    case socketClose
    case socketWSError(type: ErrorType, message: String, code: UInt16)
    case socketError(message: String)
    case pingMessageFail
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, WebSocketDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.text = placeholderText
            textView.textColor = UIColor.lightGray
        }
    }
    var placeholderText: String = "Enter your message here"
    private var webSocket: WebSocket?
    private var socketState = SocketState.close
    var message = ChatMessageDto(user: "1", msg: "")
    private let socketConnectionStateSubject = CurrentValueSubject<SocketConnectionState, Never>(.disconnected)
    private var connectionState: SocketConnectionState {
        return socketConnectionStateSubject.value
    }
    var receivedData: [ChatMessageDto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        textView.delegate = self
        tableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageTableViewCell")
        connect()
    }
    
    @IBAction func btnDisconnectTapped(_ sender: Any) {
        webSocket?.disconnect()
    }
    @IBAction func btnConnectTapped(_ sender: Any) {
        receivedData = []
        webSocket?.connect()
    }
    
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocket) {
        webSocket?.onEvent = { [weak self] event in
            guard let self = self else {
                return
            }
            switch event {
            case .connected(let headers):
                //      isConnected = true
                print("websocket is connected: \(headers)")
                self.socketState = .open
                self.socketConnectionStateSubject.value = .connected
                break
            case .disconnected(let reason, let code):
                //      isConnected = false
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                print("Received text: \(string)")
                self.messageReceived(message: string)
                break
            case .binary(let data):
                print("Received data: \(data.count)")
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                break
                //      isConnected = false
            case .error(_):
                print("error")
            }
        }
    }
    
    func connect() {
        guard let url = URL(string: "ws://0.tcp.in.ngrok.io:13368/read?user=2") else { return }
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        if webSocket != nil {
            webSocket?.disconnect()
        }
        let socked = WebSocket(request: request)
        webSocket = socked
        webSocket?.connect()
        webSocket?.delegate = self
    }
    
    @IBAction func sendBtnTapped(_ sender: Any) {
        print(textView.text ?? "")
        let text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty, !(text == placeholderText) else { return }
        self.message = ChatMessageDto(user: "1", msg: text)
        self.sendChatMessage(message: self.message)
        self.textView.text = ""
    }
    
    func sendChatMessage(message: ChatMessageDto) {
        Task {
            var isMessageSend = false
            do {
                isMessageSend = try await sendMessage(message: message)
                tableView.reloadData()
                tableView.scrollToBottom()
            } catch let error {
                print("\(error)")
            }
            return isMessageSend
        }
    }
    
    func messageReceived(message: String) {
        let jsonData = message.data(using: .utf8)!
        let data = try! JSONDecoder().decode(ChatMessageDto.self, from: jsonData)
        receivedData.append(data)
        tableView.reloadData()
        tableView.scrollToBottom()
    }

    private func sendMessage(message: ChatMessageDto) async throws -> Bool {
        let jsonData = try JSONEncoder().encode(message)
        receivedData.append(message)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return try await withUnsafeThrowingContinuation { continuation in
            guard socketState == .open && connectionState == .connected else {
                if socketState == .close {
                    continuation.resume(throwing: WebSocketError.socketClose)
                } else {
                    continuation.resume(throwing: WebSocketError.notConnected)
                }
                return
            }
            webSocket?.write(string: jsonString, completion: {
                continuation.resume(returning: true)
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
        let element = receivedData[indexPath.row]
        cell.configure(element: element)
        return cell
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
}
extension UITableView {
    func scrollToBottom(animated: Bool = true) {
        let sections = self.numberOfSections
        let rows = self.numberOfRows(inSection: sections - 1)
        if (rows > 0){
            self.scrollToRow(at: NSIndexPath(row: rows - 1, section: sections - 1) as IndexPath, at: .bottom, animated: true)
        }
    }
}

