//
//  PageContentView.swift
//  DYZB
//
//  Created by MacMini on 2017/8/4.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit


protocol  PageContentViewDelegate : class{
    
    func pageContentView(contentView : PageContentView, progress : CGFloat , sourceIndex : Int , targetIndex : Int)
    
}



public let ContentCellID = "ContentCellID"



class PageContentView: UIView {
    
    //MARK:- 定义属性
    public var childVcs : [UIViewController]
    public weak var parentViewController : UIViewController?
    public var startOffsetX : CGFloat = 0
    //设置代理属性
    weak var delegate : PageContentViewDelegate?
    public var isForbidScrollDelegate : Bool = false
    
    // MARK: - 懒加载属性,闭包中加入weak
    public lazy var collectionView : UICollectionView = {[weak self] in
        
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
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
            
            parentViewController?.addChildViewController(childVc)
            
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



//MARK: - 遵守uicollectionviewdelegate
extension PageContentView : UICollectionViewDelegate{
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //0.判断是否上点击事件
        if isForbidScrollDelegate { return }
        
        //1.获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX {
            //左滑
            //1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            //2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                
                targetIndex = childVcs.count - 1
                
            }
            
            //4.如果完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW {
                
                progress = 1
                targetIndex = sourceIndex
            }
            
            
        }else{
            
            //右滑
            //1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            //2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            //3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                
                sourceIndex = childVcs.count - 1
            }
        }
        
        //3.将progress/sourceIndex/targetIndex传递给titleView
        print("progress:\(progress) sourceIndex:\(sourceIndex) targetIndex:\(targetIndex)")
        
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
        
        
    }
    
}





//MARK: - 对外暴露的方法
extension PageContentView {
    
    public func setCurrentIndex(currentIndex : Int){
        
        //1.记录需要进行执行代理方法
        isForbidScrollDelegate = true
        
        //滚动到指定位置
        let offssetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint.init(x: offssetX, y: 0), animated:false)
        
        
        
        
        
    }
}












































