//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by MacMini on 2017/8/7.
//  Copyright © 2017年 MacMini. All rights reserved.
//


/*
 1.请求0/1数组，并转成模型对象
 2.对数据进行排序
 3.显示的HeaderView中内容
 
*/








import UIKit

class RecommendViewModel {

    // MARK: - 懒加载属性  数组属性
    public lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    public lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    public lazy var prettyGroup : AnchorGroup = AnchorGroup()

    
}



// MARK: - 发送网络请求
extension RecommendViewModel {

    func requestData(finishCallback : @escaping () -> ()) {
        
        //0.定义参数
        let parameters = ["limit":"4", "offset":"0", "time":NSDate.getCurrentTime()]
        
        
        
        //创建一个Group,目的是为了等下面三个异步请求完后，按顺序添加到数组中
        //1.1创建Group
        let dGroup = DispatchGroup()
        
        //请求第一部分推荐数据
        dGroup.enter()
        
  
        //1.请求第一部分推荐数据
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            
    
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //3.遍历字典，并且转成模型对象
            //3.1创建组
            
            //3.2设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
        
            //3.3获取主播数据
            for dict in dataArray {
            
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
                
            }
            
            //离开组
            dGroup.leave()
            print("请求第0组数据")
            
        }
        
        
        
        
        
        
        
        
        dGroup.enter()
        //2.请求第二部分颜值数据
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //3.遍历字典，并且转成模型对象
            //3.1.创建组
            //3.2给组设置属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            //3.3获取主播数据
            for dict in dataArray{
            
                let anchor = AnchorModel(dict : dict)
                self.prettyGroup.anchors.append(anchor)
                
            }
            
            //离开组
            dGroup.leave()
            print("请求到1组数据 ")
            
        }
        
        
        
        
        
        
        
        
        dGroup.enter()
        //3.请求2-12部分游戏数据
//        http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            
            
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //3.遍历数组，获取字典，并且将字典转成模型对象
            for dict in dataArray {
            
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
            for group in self.anchorGroups {
            
                for  anchor in group.anchors{
                
                    print(anchor.nickname)
                }

            }
            
            
            //离开组
            dGroup.leave()
            print("请求到2-12组数据")
            
        }
        
        
        
        
        //6.所有的数据都请求到，之后进行排序
        //创建顺序是，创建组，在每个请求体之前加入组，在结束的时候，退出组，每个异步请求都这样操作，在所有请求结束后，写出下面的方法
        dGroup.notify(queue: DispatchQueue.main){
        
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            
            finishCallback()
        }
        
    }
}










































