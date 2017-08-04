//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by MacMini on 2017/8/4.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit


//对UIBarButtonItem进行拓展
extension UIBarButtonItem{
    
    //对类方法进行拓展
    class func createItem(imageName : String, heighImageName : String, size : CGSize) -> UIBarButtonItem {
        
        let btn = UIButton()
        
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        btn.setImage(UIImage.init(named: heighImageName), for: .highlighted)
        btn.frame = CGRect.init(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem.init(customView: btn)
    }
    
    
    
    
    //遍历构造函数:1.必须以convenience开头     2.在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(imageName : String, heighImageName : String = "", size : CGSize = CGSize.zero) {
        
        //对于传参的参数，进行了空值判断，进行了代码的健壮性
        
        
        let btn = UIButton()
        
        
        
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        if heighImageName != "" {
            btn.setImage(UIImage.init(named: heighImageName), for: .highlighted)
        }
        
        
        if size == CGSize.zero {
            
            btn.sizeToFit()
       
        }else{
        
            btn.frame = CGRect.init(origin: CGPoint.zero, size: size)
        }
        

        
        self.init(customView : btn)

    }
    
    
    
    
    
    
    
}

