//
//  MianViewController.swift
//  DYZB
//
//  Created by MacMini on 2017/8/2.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit

class MianViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //设置标签栏控制器
        
        addChildVc(storyName: "Home")
        addChildVc(storyName: "Live")
        addChildVc(storyName: "Follow")
        addChildVc(storyName: "Profile")
        
        
        
        
        
    }
    
    
    
    private func addChildVc(storyName : String) {
        
        //1.通过storyboard获取控制器
        let childVc = UIStoryboard.init(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        //2.将childVC作为子控制器
        addChildViewController(childVc)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
