//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by MacMini on 2017/8/8.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit
import Kingfisher


class CollectionGameCell: UICollectionViewCell {
    
    
    // MARK: - 控件属性
    
    @IBOutlet var iconImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    // MARK: - 定义模型属性
    var group : AnchorGroup?{
        didSet{
        
            //轮播图下面的一行按钮标题
            titleLabel.text = group?.tag_name
            
            //轮播图下面的一行按钮图片
//            let iconURL = NSURL.init(string: group?.icon_url ?? "")
            
            iconImageView.kf.setImage(with: URL.init(string: (group?.icon_url)!), placeholder: UIImage.init(named: "tabVideoHL"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
        
    
    
    // MARK: - 系统回掉
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
