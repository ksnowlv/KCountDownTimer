//
//  ViewController.swift
//  KCountDownTimer
//
//  Created by ksnowlv on 2017/12/13.
//  Copyright © 2017年 ksnowlv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer:KCountTimer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.timer = KCountTimer()
        timer.countTimerBlock = { (_ sender:AnyObject, _ timeOffset:TimeInterval) -> Void in
            print("time = \(timeOffset)")
        }
        
        timer.timeInterval = 2.0
        
        
        //timer.setIsOpen(isOpen: true)
    }
    
    deinit {
        self.timer.setIsOpen(isOpen: false)
    }
    
    @IBAction func handleStartTimer(sender:AnyObject) {
        self.timer.setIsOpen(isOpen: true)
    }
    
    @IBAction func handleStopTimer(sender:AnyObject) {
        self.timer.setIsOpen(isOpen: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

