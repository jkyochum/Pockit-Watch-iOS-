//
//  EditCellViewController.swift
//  Pockit Watch
//
//  Created by Jeremy on 3/3/18.
//
//

import UIKit
import CoreData

class EditCellViewController: UIViewController {

    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var editDescriptionLabel: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    
    var timeText = ""
    var descText = ""
    
    var data = [Time]()
    var path = ""
    var index = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = data[index].time
        editDescriptionLabel.text = data[index].time_description
        
        updateButton.layer.cornerRadius = 5
        updateButton.layer.shadowColor = UIColor.black.cgColor
        updateButton.layer.shadowRadius = 5
        updateButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        updateButton.layer.shadowOpacity = 2
    }

   
    
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        
        if editDescriptionLabel.text != ""{
            data[index].time = timeLabel.text
            data[index].time_description = editDescriptionLabel.text
            appDelegate.saveContext()
        }
        
        /*let task = Time(context: context)
        task.setValue(timeLabel.text, forKey: "time")
        task.setValue(editDescriptionLabel.text, forKey: "time_description")*/
        
        /*let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Time")
        
        do{
            let results = try context.fetch(request)
            
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    if let timeDesc = result.value(forKey: "time_description")  as? String{
                        print (timeDesc)
                    }
                }
            }
        }
        catch{
         
        }*/
    }
}
