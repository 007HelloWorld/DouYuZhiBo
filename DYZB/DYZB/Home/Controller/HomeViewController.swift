//
//  HomeViewController.swift
//  DYZB
//
//  Created by MacMini on 2017/8/4.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        //设置UI界面
        setupUI()
    }

}




//  MARK: - 设置UI界面
extension HomeViewController{
    
    public func setupUI(){
        
        //1.设置导航栏控制
        setupNavigationBar()
        
    }
    
    
    private func setupNavigationBar(){
        
        //1.设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "Image_launch_logo")
        
        
    
        
        
        
        //2.设置右侧的Item
        
        let size = CGSize.init(width: 40, height: 40)
        
        //下面方法是对类方法进行拓展
//        //历史
//        let historyItem = UIBarButtonItem.createItem(imageName: "image_my_history", heighImageName: "image_my_history", size: size)
//        
//        //搜索
//        let searchItem = UIBarButtonItem.createItem(imageName: "searchIconDark", heighImageName: "searchIcon", size: size)
//        
//        //二维码
//        let qrcodeItem = UIBarButtonItem.createItem(imageName: "qr_er_btn", heighImageName: "qr_er_btn_Selected", size: size)
        
        
        
        
        
        //下面使用构造方法
        //历史
        let historyItem = UIBarButtonItem.init(imageName: "image_my_history", heighImageName: "image_my_history", size: size)
        
        //搜索
        let searchItem = UIBarButtonItem.init(imageName: "searchIconDark", heighImageName: "searchIcon", size: size)
        
        //二维码
        let qrcodeItem = UIBarButtonItem.init(imageName: "qr_er_btn", heighImageName: "qr_er_btn_Selected", size: size)
        
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
        
        
        
    }
    
    
}
