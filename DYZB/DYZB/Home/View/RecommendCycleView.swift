//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by MacMini on 2017/8/8.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"


class RecommendCycleView: UIView {
    
    // MARK: - 控件属性
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var pageControl: UIPageControl!
    
    
    // MARK: - 定时器
    var cycleTimer : Timer?
    
    
    
    // MARK: - 定义属性
    var cycleModels : [CycleModel]?{
        didSet{
            
            //1.刷新collectionView
            collectionView.reloadData()
            
            //2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //3.默认滚动到中间某一个位置.这方法是当向左边滚动的时候，没有数据了，就创建100个数据，放到第0个部分，在左边
            let indexPath = NSIndexPath.init(item: (cycleModels?.count ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            //4.添加定时器
            removeCycleTimer()//添加之前先移除定时器
            addCycleTimer()
            
        }
    }
    
    
    
    
    
    
    //这个方法是表示该控件刚从xib中加载出来
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        //设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册cell
        collectionView.register(UINib.init(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        //代理方法全部在xib中做了
        
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        //设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
        //该部分可以在xib中进行设置
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
//        layout.scrollDirection = .horizontal
//        collectionView.isPagingEnabled = true
        
    }
    
    
    
    
    
    
}



//MARK:- 提供一个快速创建View的类方法
extension RecommendCycleView{

    class func recommendCycleView() -> RecommendCycleView {
        
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
        
    }
}



//MARK:-遵守UICollectionView的数据源协议
extension RecommendCycleView : UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //这里是一个可选链，返回的一定是可选类型，这里要求的是int类型,下面表示的是，如果前面没有值，那么就执行后面的操作
        return (cycleModels?.count ?? 0) * 10000
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        //如果上面返回的count等于0，那么就不会走下面的方法，所以下面的方法肯定是有值的
        
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        
        
        return cell
    }
}



//MARK:-遵守UICollectionView的代理协议
extension RecommendCycleView : UICollectionViewDelegate{

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        
        //2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
    }
    
    //滚动视图将要滚动的时候，移除定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        removeCycleTimer()
        
    }
    
    
    //滚动视图结束滚动的时候，添加定时器
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        addCycleTimer()
        
    }
    
    
    
}



//MARK:- 对定时器对操作方法
extension RecommendCycleView{

    //开启定时器
    public func addCycleTimer(){
        cycleTimer = Timer.init(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    
    //移除定时器
    public func removeCycleTimer(){
    
        cycleTimer?.invalidate()//从运行循环中移除
        cycleTimer = nil
    }
    
    
    @objc private func scrollToNext(){
        
        //1.获取滚动到的偏移量
        let currentOffSetX = collectionView.contentOffset.x
        let offsetX = currentOffSetX + collectionView.bounds.width
        
        
        //2.滚动该位置
        collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
        
    }
    
    
}











