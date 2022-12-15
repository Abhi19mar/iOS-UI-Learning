//
//  ViewController.swift
//  ScrollViewPractice
//
//  Created by Abhishek Goel on 14/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        
        scrollView.setContentOffset(CGPoint(x: sender.selectedSegmentIndex * Int(pageWidth()), y: 0), animated: true)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func pageWidth() -> CGFloat {
        return scrollView.frame.width
    }


}

