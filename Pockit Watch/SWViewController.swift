//
//  ViewController.swift
//  Pockit Watch
//
//  Created by Jeremy Yochum on 2/15/18.
//
//

import UIKit

class SWViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    //for stopwatch----------------------------------
    
    var timer = Timer()
    var minutes: Int = 0
    var seconds: Int = 0
    var fractions: Int = 0
    var laps: [String] = []
    
    var stopwatchString: String = "00:00:00"
    
    var resetStopwatch: Bool = false
    var startStopwatch: Bool = true
    var addLap: Bool = false
    
  
    @IBOutlet var btnStop: UIButton?
    @IBOutlet var btnStart: UIButton?
    @IBOutlet var btnReset: UIButton?
    @IBOutlet var btnLap: UIButton?

    @IBOutlet weak var btnAdd: UIBarButtonItem!
    
    @IBOutlet var lapsTableView: UITableView!
    @IBOutlet var displayTimeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        btnStart?.layer.cornerRadius = 7
        btnStop?.layer.cornerRadius = 7
        btnReset?.layer.cornerRadius = 7
        btnLap?.layer.cornerRadius = 7
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addViewSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "addViewSegue"{
            let destViewController : AddViewController = segue.destination as! AddViewController
            
            destViewController.timeText = displayTimeLabel.text!
        }
     
     }
    
    
    @IBAction func start(sender: AnyObject) {
        
        if startStopwatch == true{
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(SWViewController.updateStopwatch), userInfo: nil, repeats: true)
            btnAdd.isEnabled = false
            startStopwatch = false
            addLap = true
            resetStopwatch = false
        }
        
    }
    
    @IBAction func stop(sender: AnyObject) {
        
        if startStopwatch == false{
            btnAdd.isEnabled = true
            timer.invalidate()
            startStopwatch = true
            resetStopwatch = true
            addLap = false
        }
        
    }
    
    @IBAction func lap(sender: AnyObject) {
        
        if addLap == true{
            laps.insert(stopwatchString, at: 0)
            lapsTableView.reloadData()

        }
    }
    
    @IBAction func reset(sender: AnyObject) {
        
        if startStopwatch == true{
            addLap = false
            btnAdd.isEnabled = false
            laps.removeAll(keepingCapacity: false)
            lapsTableView.reloadData()
            
            minutes = 0
            seconds = 0
            fractions = 0
            
            stopwatchString = "00:00:00"
            
            displayTimeLabel.text = stopwatchString
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
        
        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel?.text = "Lap \(laps.count - indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return laps.count
        
    }
    
    func updateStopwatch(){
        fractions += 1
        if(fractions == 100){
            seconds+=1
            fractions = 0
        }
        if (seconds == 60){
            minutes+=1
            seconds=0
        }
        
        let fractionString = String(format: "%02d", fractions)
        
        let secondString = String(format: "%02d", seconds)
        
        let minuteString = String(format: "%02d", minutes)
        
        stopwatchString = "\(minuteString):\(secondString):\(fractionString)"
        displayTimeLabel.text = stopwatchString
    }
    
    
}
