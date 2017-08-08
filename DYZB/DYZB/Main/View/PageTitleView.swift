//
//  PageTitleView.swift
//  DYZB
//
//  Created by MacMini on 2017/8/4.
//  Copyright © 2017年 MacMini. All rights reserved.
//

import UIKit


//MARK: - 定义协议
//代理的写法
protocol PageTitleViewDelegate : class {
    
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

//MARK: - 定义常量
public let KScrollLineH : CGFloat = 2
//元组
public let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85,85,85)
public let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255,128,0)



//MARK: - 定义PageTitleView类
class PageTitleView: UIView {
    
    //MARK: - 定义属性
    public var titles : [String]
    public var currentIndex : Int = 0
    //代理的属性
    weak var delegate : PageTitleViewDelegate?
    
    
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
            label.textColor = UIColor.init(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            
            //3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect.init(x: labelX, y: labelY, width: labelW, height: labelH)
            
            
            
            //4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            
            //5.给Label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(titleLabelClick))
            label.addGestureRecognizer((tapGes))
            
            
            
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
        firstLabel.textColor = UIColor.init(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect.init(x: firstLabel.frame.origin.x, y: frame.height - KScrollLineH, width: firstLabel.frame.width, height: KScrollLineH)
        
    }
}






//MARK:- 监听Label的点击
extension PageTitleView{
    
    //事件监听，前面要加@objc
    @objc public func titleLabelClick(tapGes : UITapGestureRecognizer){
        
        //0.获取当前label
        guard let currentLabel = tapGes.view as? UILabel else { return }
    
        
        //1.如果是重复点击同一个title，那么直接返回
        if currentLabel.tag == currentIndex { return }
        
        
        //2.获取之前的lable
        let oldLabel = titleLabels[currentIndex]
        
        
        //3.切换文字的颜色
        currentLabel.textColor = UIColor.init(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor.init(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //保存最新label的下标值
        currentIndex = currentLabel.tag
        
        //5.滑动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理做事情
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
        
    }
}





//MARK: - 对外暴露的方法
extension PageTitleView{
    
    func setTitleWithProgress(progress : CGFloat , sourceIndex : Int , targetIndex : Int) {
        
        //1.取出来sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.对渐变做个处理
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.颜色的渐变
        //3.1取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        //3.2变化sourceLabel
        sourceLabel.textColor = UIColor.init(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        //3.3变化targetLabel
        targetLabel.textColor = UIColor.init(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        //4.记录最新的index
        currentIndex = targetIndex
    }
    
}












































