//
//  AnchorGroup.swift
//  DYZB
//
//  Created by MacMini on 2017/8/7.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {

    
    //定义主播的模型对象数组
    public lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    //该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
    
        //属性监听器
        didSet {
        
            guard let room_list = room_list else { return }
            for dict in room_list {
                
                anchors.append(AnchorModel(dict : dict))
            }
        }
    }
    
    //组显示的标题
    var tag_name : String = ""
    
    //组显示的图标
    var icon_name : String = "home_header_normal"
    
    init(dict : [String : NSObject]) {
        
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
