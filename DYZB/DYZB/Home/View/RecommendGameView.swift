//
//  RecommendGameView.swift
//  DYZB
//
//  Created by MacMini on 2017/8/8.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10


class RecommendGameView: UIView {

    
    // MARK: - 定义数据的属性
    var groups : [AnchorGroup]?{
        didSet{
            
            //1.在轮播图下面有一行按钮，前面带有热门，还有一个不需要的参数，在这里进行删除操作
            groups?.removeFirst()
            groups?.removeFirst()
            
            
            //2.添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            
            collectionView.reloadData()
        }
    }
    
    
    
    
    // MARK: - 控件属性
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        //让控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册cell
        collectionView.register(UINib.init(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        
        //给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsetsMake(0, kEdgeInsetMargin, 0, kEdgeInsetMargin)
        
    }
    
}



//MARK:-提快速创建的类方法
extension RecommendGameView{

    class func recommendGameView() -> RecommendGameView {
        
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)!.first as! RecommendGameView
        
    }
}



//MARK:-遵守UICollectionView的数据源协议
extension RecommendGameView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return groups?.count ?? 0
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.group = groups![indexPath.item]
        
        
        return cell
    }
    
    
    
}




























