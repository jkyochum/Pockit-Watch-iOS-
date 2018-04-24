//
//  TViewController.swift
//  Pockit Watch
//
//  Created by Jeremy on 2/21/18.
//
//

import UIKit
import AVFoundation
import AudioToolbox

class TViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet var startTimerButton: UIButton!
    @IBOutlet weak var timerResetButton: UIButton!
    @IBOutlet weak var timerPauseButton: UIButton!
    @IBOutlet weak var timerResetButton2: UIButton!

    @IBOutlet weak var secondsPicker: UIPickerView!
    @IBOutlet weak var secondsLabel: UILabel!
    
    @IBOutlet weak var minutesPicker: UIPickerView!
    @IBOutlet weak var minutesLabel: UILabel!
    
    @IBOutlet weak var hoursPicker: UIPickerView!
    @IBOutlet weak var hoursLabel: UILabel!
    
    var time = ""
    
    var seconds = 0
    var minutes = 0
    var hours = 0
    var timer = Timer()
    var isRunning = false
    var resumeTapped = false
    
    var audioPlayer = AVAudioPlayer()
    
    var secondsData: [String] = [String]()
    var minutesData: [String] = [String]()
    var hoursData: [String] = [String]()
    
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if !(seconds == 0 && minutes == 0 && hours == 0){
            if isRunning == false{
                timeCalc()
                timerLabel.isHidden = false
                timerLabel.textColor = UIColor.black
                timerResetButton.isHidden = false
                timerPauseButton.isHidden = false
                startTimerButton.isHidden = true
                secondsPicker.isHidden = true
                minutesPicker.isHidden = true
                hoursPicker.isHidden = true
                hoursLabel.isHidden = true
                minutesLabel.isHidden = true
                secondsLabel.isHidden = true
                runTimer()
                timerLabel.text = timeString(time: TimeInterval(seconds))
                timerLabel.font = timerLabel.font.withSize(81)
                isRunning = true
            }
        }
        else{
            timerLabel.text = "Choose a starting time"
            timerLabel.textColor = UIColor.black
            timerLabel.font = timerLabel.font.withSize(20)
            timerLabel.isHidden = false
        }
        
        
        
    }
    
    @IBAction func resetButton2Tapped(_ sender: UIButton) {
        timer.invalidate()
        secondsPicker.selectRow(0, inComponent: 0, animated: true)
        minutesPicker.selectRow(0, inComponent: 0, animated: true)
        hoursPicker.selectRow(0, inComponent: 0, animated: true)
        seconds = 0
        minutes = 0
        hours = 0
        timerLabel.isHidden = true
        timerResetButton.isHidden = true
        timerPauseButton.isHidden = true
        startTimerButton.isHidden = false
        secondsPicker.isHidden = false
        minutesPicker.isHidden = false
        hoursPicker.isHidden = false
        hoursLabel.isHidden = false
        minutesLabel.isHidden = false
        secondsLabel.isHidden = false
        timerResetButton2.isHidden = true
        isRunning = false

    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        secondsPicker.selectRow(0, inComponent: 0, animated: true)
        minutesPicker.selectRow(0, inComponent: 0, animated: true)
        hoursPicker.selectRow(0, inComponent: 0, animated: true)
        seconds = 0
        minutes = 0
        hours = 0
        timerLabel.isHidden = true
        timerResetButton.isHidden = true
        timerPauseButton.isHidden = true
        startTimerButton.isHidden = false
        secondsPicker.isHidden = false
        minutesPicker.isHidden = false
        hoursPicker.isHidden = false
        hoursLabel.isHidden = false
        minutesLabel.isHidden = false
        secondsLabel.isHidden = false
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isRunning = false
    }
    
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false{
            timerPauseButton.setTitle("Resume", for: .normal)
            timer.invalidate()
            self.resumeTapped = true
        }
        else{
            runTimer()
            timerPauseButton.setTitle("Pause", for: .normal)
            self.resumeTapped = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.secondsPicker.delegate = self
        self.secondsPicker.dataSource = self
        
        self.minutesPicker.delegate = self
        self.minutesPicker.dataSource = self
        
        self.hoursPicker.delegate = self
        self.hoursPicker.dataSource = self
        
        secondsData = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
        
        minutesData = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
        
        hoursData = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
        
        startTimerButton.layer.cornerRadius = 5
        startTimerButton.layer.shadowColor = UIColor.black.cgColor
        startTimerButton.layer.shadowRadius = 5
        startTimerButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        startTimerButton.layer.shadowOpacity = 2
        timerPauseButton.isHidden = true
        timerResetButton.isHidden = true
        timerLabel.isHidden = true
        timerResetButton2.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //how many columns/components in the picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //how many rows in each column/component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == secondsPicker{
            return secondsData.count
        }
        else if pickerView == minutesPicker{
            return minutesData.count
        }
        else{
            return hoursData.count
        }
    }
    
    //returns the number based on the index of the row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == hoursPicker{
            return hoursData[row]
            
        }
        else if pickerView == minutesPicker{
            return minutesData[row]
        }
        else{
            return secondsData[row]
        }
    }
    
    //assigning the selected value to a variable
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == hoursPicker{
            hours = Int(hoursData[row])!
            //seconds += Int(hoursData[row])! * 60 * 60 - seconds
        }
        else if pickerView == minutesPicker{
            minutes = Int(minutesData[row])!
            //seconds += Int(minutesData[row])! * 60 - seconds
        }
        else{
            seconds = Int(secondsData[row])!
        }
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    func updateTimer(){
        if seconds < 1{
            timer.invalidate()
            AudioServicesPlayAlertSound(1304)
            timerLabel.text = "Time's Up!"
            timerLabel.font = timerLabel.font.withSize(70)
            timerLabel.textColor = UIColor.orange
            timerResetButton2.isHidden = false
            timerResetButton.isHidden = true
            timerPauseButton.isHidden = true
        }
        else{
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
        
    }

    func timeString(time:TimeInterval)-> String{
        
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func timeCalc(){
        seconds = seconds + (minutes * 60) + (hours * 60 * 60)
    }
    
}
