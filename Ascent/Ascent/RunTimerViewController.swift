//
//  RunTimerViewController.swift
//  Ascent
//
//  Created by Dennis Chen on 2022-07-27.
//

import UIKit

class RunTimerViewController: UIViewController {
    @IBOutlet weak var CurrentTimeDisplay: UILabel!
    @IBOutlet weak var IntervalTimer: UILabel!
    @IBOutlet weak var TargetTimeDisplay: UILabel!
    
    var collapsed = false
    var currentTime = 0
    let timeLimit = timerHours * 3600 + timerMinutes * 60
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // seconds
        TargetTimeDisplay.text = String(timerHours) + ":" + String(timerMinutes)
        
        // delay every 1 second
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(UpdateView), userInfo: nil, repeats: true)

        // setup alert
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
    }
    
    @objc func UpdateView() {
        if collapsed {
            timer = nil
            
        }
        
        // update display times
        currentTime += 1
        self.IntervalTimer.text = String(buildInterval - currentTime%buildInterval)
        self.CurrentTimeDisplay.text = String(currentTime/3600) + ":" + String(currentTime/60)
    }
    
    @objc func appMovedToBackground() {
        if !isTimerStarted {return}
        
        let dialogMessage = UIAlertController(title: "Your exit has shaken the land!", message: "Your tower has suffered catostrophic collapse...", preferredStyle: .alert)
        // Present alert to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

