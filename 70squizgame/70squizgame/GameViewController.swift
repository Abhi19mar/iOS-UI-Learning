//
//  GameViewController.swift
//  70squizgame
//
//  Created by Abhishek Goel on 29/11/22.
//

import UIKit
import SDWebImage

class GameViewController: UIViewController {
    
    @IBOutlet weak var stackViewUpper: UIStackView!
    @IBOutlet weak var stackViewLower: UIStackView!
    @IBOutlet var btnArrayUpperLayer: [UIButton]!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblLevel: UIButton! {
        didSet {
            lblLevel.layer.cornerRadius = 0.5 * lblLevel.bounds.size.height
        }
    }
    @IBOutlet var btnArrayLowerLayer: [UIButton]!

    let viewModel = GameViewModel()
    var name: String = ""
    var firstName: String = ""
    var secondName: String = ""
    let letters = "aeiouqwrtycmnblpudg"
    var randomValueForFirstName: String = ""
    var randomValueForSecondName: String = ""
    var totalCharactersForFirstName: Int = 0
    var totalCharactersForSecondName: Int = 0
    var flag: Int = 0
    var element = 0
    var buttonTagUpper: Int = 0
    var buttonTagLower: Int = 0
    var isSpaceEncountered: Bool = true
    var isStackfilled = Observable<Bool>(value: false)
    var checkAnswer: String = ""
    var level: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        viewModel.fetchData(level: level, usr: 2)
        viewModel.data.subcribe { data in
            self.lblLevel.setTitle(String(self.level), for: .normal)
            self.name = data?.name ?? ""
            let imageURL = URL(string: data?.url ?? "")
            self.imgView.sd_setImage(with: imageURL)
            self.checkCount()
            self.displayOptions()
        }
        
        isStackfilled.subcribe { [weak self] isFilled in
            guard let self = self else { return }
            self.checkAnswer = ""
            if isFilled {
                for i in 0..<self.stackViewUpper.arrangedSubviews.count {
                    self.checkAnswer.append((self.stackViewUpper.arrangedSubviews[i] as? UIButton)?.currentTitle ?? "")
                }
                self.checkAnswer.append(" ")
                for i in 0..<self.stackViewLower.arrangedSubviews.count {
                    self.checkAnswer.append((self.stackViewLower.arrangedSubviews[i] as? UIButton)?.currentTitle ?? "")
                }
                if self.checkAnswer.hasSuffix(" "){
                    self.checkAnswer.removeLast()
                }
                if self.checkAnswer == self.name {
                    self.setToInitialState()
                }
            }
        }
    }
    
    func setToInitialState() {
        stackViewUpper.arrangedSubviews.forEach ({$0.removeFromSuperview()})
        stackViewLower.arrangedSubviews.forEach ({$0.removeFromSuperview()})
        btnArrayUpperLayer.forEach({$0.setTitle("", for: .normal)})
        btnArrayUpperLayer.forEach({$0.isEnabled = true})
        btnArrayLowerLayer.forEach({$0.setTitle("", for: .normal)})
        btnArrayLowerLayer.forEach({$0.isEnabled = true})
        level = self.level + 2
        buttonTagLower = 0
        buttonTagUpper = 0
        flag = 0
        element = 0
        firstName = ""
        secondName = ""
        viewModel.fetchData(level: self.level, usr: 2)
    }
    
    @IBAction func btnUpperLayerTapped(_ sender: UIButton) {
        let value = sender.currentTitle ?? ""
        setValue(checkForSpace: true)
        if isSpaceEncountered == true {
            setValue(value: value)
            btnArrayUpperLayer[sender.tag].isEnabled = false
            btnArrayUpperLayer[sender.tag].setTitle("", for: .normal)
            btnArrayUpperLayer[sender.tag].backgroundColor = .clear
        }
        setValue(checkForSpace: true)
    }
    
    @IBAction func btnLowerLayerTapped(_ sender: UIButton) {
        let value = sender.currentTitle ?? ""
        setValue(checkForSpace: true)
        if isSpaceEncountered == true {
            setValue(value: value)
            btnArrayLowerLayer[sender.tag].isEnabled = false
            btnArrayLowerLayer[sender.tag].setTitle("", for: .normal)
            btnArrayLowerLayer[sender.tag].backgroundColor = .clear
        }
        setValue(checkForSpace: true)
    }
    
    func setValue(value: String = "", checkForSpace: Bool = false) {
        isSpaceEncountered = false
        for i in 0..<stackViewUpper.arrangedSubviews.count {
            if ((stackViewUpper.arrangedSubviews[i] as? UIButton)?.currentTitle == nil || (stackViewUpper.arrangedSubviews[i] as? UIButton)?.currentTitle == "")
            {
                isSpaceEncountered = true
                if !checkForSpace {
                    (stackViewUpper.arrangedSubviews[i] as? UIButton)?.setTitle(value, for: .normal)
                    (stackViewUpper.arrangedSubviews[i] as? UIButton)?.backgroundColor = .white
                }
                break
            }
        }
        if isSpaceEncountered == false {
            arrangeInLowerStack(value: value)
        }
    }
    
    func arrangeInLowerStack(value: String) {
        for i in 0..<stackViewLower.arrangedSubviews.count {
            if ((stackViewLower.arrangedSubviews[i] as? UIButton)?.currentTitle == nil || (stackViewLower.arrangedSubviews[i] as? UIButton)?.currentTitle == "")
            {
                isSpaceEncountered = true
                if !value.isEmpty {
                    (stackViewLower.arrangedSubviews[i] as? UIButton)?.setTitle(value, for: .normal)
                    (stackViewLower.arrangedSubviews[i] as? UIButton)?.backgroundColor = .white
                }
                break
            }
        }
        if isSpaceEncountered == false {
            isStackfilled.value = true
        }
    }
    
    func checkCount() {
        for i in name {
            if (i == " ") {
                flag = 1
            }
            else {
                (flag == 0) ? (firstName.append(i)) : secondName.append(i)
            }
        }
        
        for _ in firstName {
            let button = configureButton(layer: 1)
            stackViewUpper.addArrangedSubview(button)
        }
        
        for _ in secondName {
            let button = configureButton(layer: 2)
            stackViewLower.addArrangedSubview(button)
        }
    }
    
    func configureButton(layer: Int) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        if layer == 1 {
            button.tag = buttonTagUpper
            buttonTagUpper += 1
            button.addTarget(self, action: #selector(handleUpperButtonClickedAction(_:)), for: .touchUpInside)
        }
        else {
            button.tag = buttonTagLower
            buttonTagLower += 1
            button.addTarget(self, action: #selector(handleLowerButtonClickedAction(_:)), for: .touchUpInside)
        }
        return button
    }
    
    @objc func handleUpperButtonClickedAction(_ sender: UIButton) {
        let temp = sender.currentTitle
        checkForValue(temp: temp ?? "")
        (stackViewUpper.arrangedSubviews[sender.tag] as? UIButton)?.setTitle("", for: .normal)
        (stackViewUpper.arrangedSubviews[sender.tag] as? UIButton)?.backgroundColor = .black
    }
    
    @objc func handleLowerButtonClickedAction(_ sender: UIButton) {
        let temp = sender.currentTitle
        checkForValue(temp: temp ?? "")
        (stackViewLower.arrangedSubviews[sender.tag] as? UIButton)?.setTitle("", for: .normal)
        (stackViewLower.arrangedSubviews[sender.tag] as? UIButton)?.backgroundColor = .black
    }
    
    func checkForValue(temp: String) {
        var pos = 0
        var flag = 0
        for i in randomValueForFirstName {
            pos = pos + 1
            if (String(i) == temp) {
                btnArrayUpperLayer[pos-1].isEnabled = true
                btnArrayUpperLayer[pos-1].backgroundColor = .white
                if (btnArrayUpperLayer[pos-1].currentTitle != temp) {
                    btnArrayUpperLayer[pos-1].setTitle(temp, for: .normal)
                    flag = 1
                    break
                }
                else {
                    continue
                }
            }
        }
        if (flag == 0) {
            pos = 0
            for i in randomValueForSecondName {
                pos = pos + 1
                if (String(i) == temp) {
                    btnArrayLowerLayer[pos-1].isEnabled = true
                    btnArrayLowerLayer[pos-1].backgroundColor = .white
                    if btnArrayLowerLayer[pos-1].currentTitle != temp {
                        btnArrayLowerLayer[pos-1].setTitle(temp, for: .normal)
                        break
                    }
                    else {
                        continue
                    }
                }
            }
        }
    }
    
    func displayOptions() {
        imgView.layer.borderWidth = 2.0
        imgView.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        totalCharactersForFirstName = 10 - firstName.count
        totalCharactersForSecondName = 10 - secondName.count
        
        for _ in 0..<totalCharactersForFirstName {
            let randomAplhabet = String(letters.randomElement()!)
            firstName.append(randomAplhabet)
        }
        
        for _ in 0..<totalCharactersForSecondName {
            let randomAplhabet = String(letters.randomElement()!)
            secondName.append(randomAplhabet)
        }
        
        randomValueForFirstName = String(firstName.shuffled())
        randomValueForSecondName = String(secondName.shuffled())
        
        for value in randomValueForFirstName {
            btnArrayUpperLayer[element].setTitle(String(value), for: .normal)
            btnArrayUpperLayer[element].backgroundColor = .white
            element += 1
        }
        
        element = 0
        for value in randomValueForSecondName {
            btnArrayLowerLayer[element].setTitle(String(value), for: .normal)
            btnArrayLowerLayer[element].backgroundColor = .white
            element += 1
        }
    }
}

