 //
//  NSDate-Extension.swift
//  DYZB
//
//  Created by MacMini on 2017/8/7.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import Foundation

 
 
 
 extension NSDate {
 
    //扩展一个类方法
    class func getCurrentTime() -> String {
        
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
    
    
 }
