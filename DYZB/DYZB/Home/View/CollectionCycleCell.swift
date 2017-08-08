//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by MacMini on 2017/8/8.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {

    // MARK: - 控件属性
    
    @IBOutlet var iconImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    
    
    
    
// MARK: - 定义模型属性
    var cycleModel : CycleModel?{
        didSet{
    
            titleLabel.text = cycleModel?.title
            
            iconImageView.kf.setImage(with: URL.init(string: (cycleModel?.pic_url)!))
            
        }
    }
}



















































