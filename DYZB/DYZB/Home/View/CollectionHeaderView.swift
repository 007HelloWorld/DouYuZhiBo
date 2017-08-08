//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by MacMini on 2017/8/7.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    // MARK: - 控件属性
    
    @IBOutlet var titleLabel: UILabel!
    
    
    @IBOutlet var iconImageView: UIImageView!
    
    
    // MARK: - 定义模型属性
    var group : AnchorGroup?{
        didSet{
        
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage.init(named: group?.icon_name ?? "home_header_normal")
            
        }
    }
    
    
    
    


}






















































