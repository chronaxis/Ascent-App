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
    @IBOutlet var ViewParent: UIView!
    @IBOutlet weak var TowerSection: UIView!
    
    @IBOutlet weak var TowerTop: UIView!
    var collapsed = false
    var currentTime = 0
    let timeLimit = timerHours * 3600 + timerMinutes * 60
    
    // declare in scope
    var timer: Timer? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // seconds
        TargetTimeDisplay.text = String(timerHours) + ":" + String(timerMinutes)

        // setup alert
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
        // setup timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(UpdateView), userInfo: nil, repeats: true)
    }
    
    @objc func UpdateView() {
        if collapsed {
            timer?.invalidate()
            timer = nil
            
            // destroy tower
            for subview in ViewParent.subviews {
                if subview.backgroundColor == .systemBackground {
                    subview.isHidden = true
                }
            }
            
            IntervalTimer.isHidden = true
        }
        
        // update display times
        currentTime += 1
        if currentTime == buildInterval {
            TowerSection.isHidden = false
            TowerTop.isHidden = false
        }
        self.IntervalTimer.text = String(buildInterval - currentTime%buildInterval)
        
        self.CurrentTimeDisplay.text = String(currentTime/3600) + ":" + String(currentTime/60)
    }
    
    @objc func appMovedToBackground() {
        if !isTimerStarted {return}
        collapsed = true
        let alert = UIAlertController(title: "Your exit has shaken the land!", message: "Your tower has suffered catostrophic collapse...", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: ":(", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

