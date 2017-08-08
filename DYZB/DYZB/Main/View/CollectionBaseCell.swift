//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by MacMini on 2017/8/8.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    // MARK: - 控件属性
    @IBOutlet var iconImageView: UIImageView!
    
    @IBOutlet var onlineBtn: UIButton!
    
    @IBOutlet var nickNameLabel: UILabel!
    
    
    // MARK: - 定义模型属性
    var anchor : AnchorModel?{
        didSet{
        
            //0.校验模型属性
            guard let anchor = anchor  else { return }
            
            //1.取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else {
                
                onlineStr = "\(anchor.online)在线"
            }
            
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            //2.显示昵称
            nickNameLabel.text = anchor.nickname
            
            //3.设置封面图片,下载图片
            iconImageView.kf.setImage(with: URL.init(string: anchor.vertical_src))
            
        }
    }
    
    
    
    
    
    
    
    
}
