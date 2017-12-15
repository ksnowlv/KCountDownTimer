//
//  KCountDownTimer.swift
//  KCountDownTimer
//
//  Created by ksnowlv on 2017/12/13.
//  Copyright © 2017年 ksnowlv. All rights reserved.
//

import Foundation

typealias countTimerBlock = (_ sender:AnyObject,  _ timeOffset:TimeInterval) ->Void

class KCountTimer {
    
    var timeInterval:TimeInterval = 1.0
    var isTimerLoopRepeate = true
    var countTimerBlock:countTimerBlock!

    private var timer:Timer!
    private var startTime:TimeInterval = 0.0
    
    func setIsOpen(isOpen:Bool) -> Void {
        
        typealias block = ()->Void
        
        var mainBlock:block?
        
        if isOpen {
            mainBlock = { () -> Void in
                if self.timer != nil && self.timer.isValid {
                    self.timer.invalidate()
                }
                
                self.timer =  Timer.scheduledTimer(timeInterval: self.timeInterval, target: self, selector: #selector(self.handleTimeEvent(sender:)), userInfo: nil, repeats: self.isTimerLoopRepeate)
                RunLoop.current.add(self.timer, forMode: RunLoopMode.commonModes)
                self.startTime = CFAbsoluteTimeGetCurrent()
            }
        }else {
            
            mainBlock = { () ->Void in
                if self.timer != nil && self.timer.isValid {
                    self.timer.invalidate()
                }
                
                self.timer = nil
            }
        }
        
        if  Thread.isMainThread {
            mainBlock?()
            
        }else {
            DispatchQueue.main.async {
                mainBlock?()
            }
        }
    }
    
    @objc func handleTimeEvent(sender:AnyObject) -> Void {
        if self.countTimerBlock != nil {
            self.countTimerBlock(self, CFAbsoluteTimeGetCurrent() - self.startTime)
        }
    }
}
