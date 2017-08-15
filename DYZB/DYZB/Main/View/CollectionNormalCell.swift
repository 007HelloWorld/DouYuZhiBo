//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by MacMini on 2017/8/7.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    // MARK: - 定义模型属性
//    var anchr : AnchorModel?
    

    
    @IBOutlet var roomNameLabel: UILabel!
    
    //父亲方法充血，就要写override
    
    override var anchor : AnchorModel?{
        didSet{
            
            super.anchor = anchor
            
            //4.设置房间名称
            roomNameLabel.text = anchor?.room_name
            
        }
    }
}



























