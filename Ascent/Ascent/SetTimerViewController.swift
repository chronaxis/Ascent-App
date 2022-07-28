//
//  SetTimerViewController.swift
//  Ascent
//
//  Created by Dennis Chen on 2022-07-27.
//

import UIKit

var timerHours = 0
var timerMinutes = 0
var buildInterval = 5

class SetTimerViewController: UIViewController {
    @IBOutlet weak var Minutes: UITextField!
    @IBOutlet weak var Hours: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func StartTimer(_ sender: Any) {
        // get variables that may or may not be nil
        guard let getHours = Hours.text else {return}
        guard let getMinutes = Minutes.text else {return}
        
        guard let getIntHours = Int(getHours) else {return}
        guard let getIntMinutes = Int(getMinutes) else {return}
        
        timerHours = getIntHours
        timerMinutes = getIntMinutes
        isTimerStarted = true
    }
    

}
