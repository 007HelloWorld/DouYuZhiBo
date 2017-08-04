//
//  PageContentView.swift
//  DYZB
//
//  Created by MacMini on 2017/8/4.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit

public let ContentCellID = "ContentCellID"



class PageContentView: UIView {

    //MARK:- 定义属性
    public var childVcs : [UIViewController]
    public var parentViewController : UIViewController
    
    
    // MARK: - 懒加载属性
    public lazy var collectionView : UICollectionView = {
    
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        
        return collectionView
        
    }()
    

    
    
    //构造函数
    init(frame: CGRect,childVcs : [UIViewController] , parentViewController : UIViewController) {
        
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        //设置UI
        setupUI()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError(" init ")
        
    }
}




//MARK:-设置UI界面
extension PageContentView{

    public func setupUI(){
        //1.将所有的子控制器添加到父控制器中
        for childVc in childVcs {
            
            parentViewController.addChildViewController(childVc)
            
        }
        
        //2.添加UICollectionView，用于在Cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}





// MARK: - 遵守UICollectionView的代理方法
extension PageContentView : UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childVcs.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1.创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        

        //2.给cell设置内容
        for view in cell.contentView.subviews {
            
            view.removeFromSuperview()
        }
        
        
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
    
    
    
    
    
    
}




















































