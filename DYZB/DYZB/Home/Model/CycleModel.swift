//
//  CycleModel.swift
//  DYZB
//
//  Created by MacMini on 2017/8/8.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    
    //标题
    var title : String = ""
    
    //展示的图片地址
    var pic_url : String = ""
    
    //主播信息对应的字典
    var room : [String : NSObject]? {
        
        didSet{
            
            guard let room = room else { return }
            
            anchor = AnchorModel(dict: room)
        }
    }
    
    
    //主播信息对应的模型对象
    var anchor : AnchorModel?
    
    
    // MARK: - 自定义构造函数
    init(dict : [String : NSObject]) {
        
        super.init()
        
        setValuesForKeys(dict)
    }
    
    //构造函数，下面这个方法也必须要写上
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    

}


































































