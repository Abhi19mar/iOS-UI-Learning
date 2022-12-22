//
//  ViewController.swift
//  70squizgame
//
//  Created by Abhishek Goel on 29/11/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPlayTapped(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        navigationController?.pushViewController(controller, animated: true)
    }
}

