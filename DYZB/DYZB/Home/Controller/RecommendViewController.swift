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


private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kPrettyCellID = "kPrettyCellID"





class RecommendViewController: UIViewController {
    
    
    public lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    
    
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
    
//        NetworkTools.requestData(.get, URLString: "http://httpbin.org/get", parameters: ["name":"why"]) { (result) in
//            
//            print(result)
//            
//    }
        recommendVM.requestData()
    
        
    }
}







//MARK: - 设置ui界面内容
extension RecommendViewController{
    
    public func setUI(){
        
        view.addSubview(collectionView)
        
    }
}



//MARK: - 遵守collectionview代理方法
extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 8
        }
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1.定义cell
        var cell : UICollectionViewCell!
        
        if indexPath.section == 1 {
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
            
        }else {
        
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)

        }
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        
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


































