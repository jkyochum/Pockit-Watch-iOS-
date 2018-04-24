//
//  DataViewController.swift
//  Pockit Watch
//
//  Created by Jeremy on 2/27/18.
//
//

import UIKit
import CoreData

class DataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tasks = [Time]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        let cellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellIdentifier)
        }
        
        cell?.detailTextLabel?.text = self.tasks[indexPath.row].time
        cell?.textLabel?.text = self.tasks[indexPath.row].time_description
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = tableView.indexPathForSelectedRow?.row
        performSegue(withIdentifier: "editSegue", sender: index)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue"{
            if let editVC = (segue.destination) as? EditCellViewController{
                //let indexPath = self.tableView.indexPathForSelectedRow
                if let index = sender as? Int{
                    editVC.index = index
                    editVC.data = tasks
                    /*editVC.timeText = tasks[index].time!
                    editVC.descText = tasks[index].time_description!*/
                }
            }
        }
        tableView.reloadData()
    }
    
    
    func getData(){
        let fetchRequest = NSFetchRequest<Time>(entityName: "Time")
        let sort = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        do{
            tasks = try context.fetch(fetchRequest)

        }catch{
            print("Fetch failed")
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let task = tasks[indexPath.row]
            context.delete(task)
            appDelegate.saveContext()
            
            do{
                tasks = try context.fetch(Time.fetchRequest())
                
            }catch{
                print("Fetch failed")
            }
        }
        
        tableView.reloadData()
    }
    
    
    
    
}
