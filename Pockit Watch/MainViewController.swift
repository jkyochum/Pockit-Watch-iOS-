//
//  MainViewController.swift
//  Pockit Watch
//
//  Created by Jeremy on 3/6/18.
//
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var stopwatchButton: UIButton!
    @IBOutlet weak var viewButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerButton.layer.cornerRadius = 5
        timerButton.layer.shadowColor = UIColor.black.cgColor
        timerButton.layer.shadowRadius = 5
        timerButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        timerButton.layer.shadowOpacity = 1
        
        stopwatchButton.layer.cornerRadius = 5
        stopwatchButton.layer.shadowColor = UIColor.black.cgColor
        stopwatchButton.layer.shadowRadius = 5
        stopwatchButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        stopwatchButton.layer.shadowOpacity = 1
        
        viewButton.layer.cornerRadius = 5
        viewButton.layer.shadowColor = UIColor.black.cgColor
        viewButton.layer.shadowRadius = 5
        viewButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        viewButton.layer.shadowOpacity = 1
        
    }

    

}
