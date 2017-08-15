//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by MacMini on 2017/8/7.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit
import Kingfisher


class CollectionPrettyCell: CollectionBaseCell {

    @IBOutlet var cityBtn: UIButton!
    
    
    
    
    // MARK: - 定义模型属性
    override var anchor : AnchorModel? {
        //属性改变
        didSet{
    
            //1.将属性传递给父类
            super.anchor = anchor
            
            //2.所在城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)

        }
    }
}
