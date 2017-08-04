//
//  PageTitleView.swift
//  DYZB
//
//  Created by MacMini on 2017/8/4.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit

public let KScrollLineH : CGFloat = 2


class PageTitleView: UIView {

    //MARK: - 定义属性
    public var titles : [String]
    
    
    //MARK: - 懒加载属性
    public lazy var scrollView : UIScrollView = {
    
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
        
    }()
    
    
    //添加下方的滚动条
    public lazy var scrollLine : UIView = {
    
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
        
    }()
    
    
    //懒加载一个数组
    public lazy var titleLabels : [UILabel] = [UILabel]()
    
    
    
    
    
    
    
    
    
    //MARK: - 自定义构造函数
    init(frame: CGRect, title : [String]) {
        self.titles = title
        
        super.init(frame: frame)
        
        
        //设置UI界面
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
}




//MARK: - 设置UI界面
extension   PageTitleView{

    public func setupUI(){
        
        
        //1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        
        //2.添加title对应的Label
        setupTitleLabels()
        
        
        //3.设置底线和滑动的滑块
        setupBootmMenuAndScrollLine()
        
        
        
    }
    
    
    private func setupTitleLabels(){
    
        
        //0.确定label的一些frame值
        //3.设置label的frame
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - KScrollLineH
        let labelY : CGFloat = 0
        
        
        
        for (index,title) in titles.enumerated() {
            
            //1.创建UILabel   
            let label = UILabel()
            
            
            //2.设置Label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            
            //3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect.init(x: labelX, y: labelY, width: labelW, height: labelH)
            
            
            
            //4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            
        }
        
        
        
        
    }
    
    private func setupBootmMenuAndScrollLine(){
        
        //1.添加底线
        let boottomLine = UIView()
        boottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        boottomLine.frame = CGRect.init(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(boottomLine)
        
        
        //2.添加scrollLine
        //2.1获取第一个Label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect.init(x: firstLabel.frame.origin.x, y: frame.height - KScrollLineH, width: firstLabel.frame.width, height: KScrollLineH)
        
        
        
        
        
        
    }
    
    
    
    
}

























































