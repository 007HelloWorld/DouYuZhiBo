//
//  RecommendViewController.swift
//  DYZB
//
//  Created by mac pro on 2017/8/6.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kCycleViewH = kScreenW * 3 / 8//轮播图的高度
private let kGameViewH : CGFloat = 90 //轮播图下面的推荐游戏的按钮高度

private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kPrettyCellID = "kPrettyCellID"




class RecommendViewController: UIViewController {
    
    
    public lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    //懒加载一个头部视图
    public lazy var cycleView : RecommendCycleView = {
    
        let cycleView = RecommendCycleView.recommendCycleView()
        
        cycleView.frame = CGRect.init(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        
        return cycleView
    }()
    
    
    //MARK:- 系统回调函数
    public lazy var collectionView : UICollectionView = {
        
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize.init(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH), collectionViewLayout: layout)
        collectionView.register(UINib.init(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.register(UINib.init(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib.init(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        
        
        
        
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        return collectionView
    }()
    
    
    
    //懒加载滚动视图下面的推荐游戏按钮
    public lazy var gameView : RecommendGameView = {
    
        let gameView = RecommendGameView.recommendGameView()
        
        gameView.frame = CGRect.init(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        return gameView
    }()
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setUI()
        
        //发送网络请求
        loadData()
        
        
        
        
    }
}

//MARK:-发送网络请求
extension RecommendViewController {

    public func loadData() {
        
        
        //1.请求推荐数据
        recommendVM.requestData{
            
            //1.展示推荐数据
            self.collectionView.reloadData()
            
            //2.将数据传递给GameView
            self.gameView.groups = self.recommendVM.anchorGroups
            
        }
        
        
        //2.请求轮播数据
        recommendVM.requestCycleData {
            
            self.cycleView.cycleModels = self.recommendVM.cycleModels
            
        }
        
    }
}







//MARK: - 设置ui界面内容
extension RecommendViewController{
    
    public func setUI(){
        
        //1.将UICollectionView添加到控制器的view中
        view.addSubview(collectionView)
        
        //2.将CycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        
        
        //3.将gameView添加collectionView中
        collectionView.addSubview(gameView)
        
        
        //4.设置collectionView的内边距,设置这部分用来把轮播图位置显示出来
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, 0, 0)
        
        
        
        
    }
}



//MARK: - 遵守collectionview代理方法
extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        let group = recommendVM.anchorGroups[section]
        
        return group.anchors.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //0.取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]

        //1.定义cell
        var cell : CollectionBaseCell!
        
        
        //2.取出cell
        if indexPath.section == 1 {
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
        }else {
        
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
            
        }
        
        //3.将模型赋值给cell
        cell.anchor = anchor
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        //2.取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
        
        
        
        return headerView
        
    }
    
    
    // MARK: - 对不同section中cell高度的设置, 动态设置
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            
            return CGSize.init(width: kItemW, height: kPrettyItemH)
            
        }else {
        
            return CGSize.init(width: kItemW, height: kNormalItemH)
        }
        
    }
    
    
    
    
}


































