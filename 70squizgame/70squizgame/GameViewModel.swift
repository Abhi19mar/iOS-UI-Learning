//
//  GameViewModel.swift
//  70squizgame
//
//  Created by Abhishek Goel on 06/12/22.
//

import Foundation
import Alamofire

class GameViewModel {
    
    var data = Observable<ResponseDTO?>(value: nil)
    
    func fetchData(level: Int, usr: Int) {
        let parameters = ["level": level, "usr": usr]
        AF.request("https://7156-2401-4900-1c5e-e6d2-9078-63c-2125-bbac.in.ngrok.io/imgUrl", parameters: parameters)
            .validate()
            .responseDecodable(of: ResponseDTO.self) { (response) in
                guard let data = response.value else { return }
                self.data.value = data
          }
    }
}
