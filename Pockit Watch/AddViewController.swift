//
//  AddViewController.swift
//  Pockit Watch
//
//  Created by Jeremy on 2/28/18.
//
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var logButton: UIButton!

    @IBOutlet weak var labelForTextbox: UILabel!
    
    var timeText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = timeText
        
        logButton.layer.cornerRadius = 5
        logButton.layer.shadowColor = UIColor.black.cgColor
        logButton.layer.shadowRadius = 5
        logButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        logButton.layer.shadowOpacity = 2
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if descriptionText.text == ""{
            labelForTextbox.text = "You must enter a time description"
            labelForTextbox.textColor = UIColor.red
        }
        else{
            let task = Time(context: context)
            task.time = timeLabel.text!
            task.time_description = descriptionText.text!
            task.date = Date() as NSDate?
            
            appDelegate.saveContext()
            performSegue(withIdentifier: "DataViewSegue", sender: self)
        }
        
    }
    
    
}
