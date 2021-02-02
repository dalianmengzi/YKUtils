//
//  Extension+UIBarButtonItem.swift
//  yktIcve
//
//  Created by 志辉教育 on 2020/1/20.
//  Copyright © 2020 zqyou. All rights reserved.
//

import UIKit

public extension UIBarButtonItem{
    //定义返回
       static func setBackButtonItem(item:UIBarButtonItem)  {
        item.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "iconfont", size: 20) as Any], for:.normal)
        item.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "iconfont", size: 20.0) as Any], for:.highlighted)
       }
       
       //定义删除
       static func setdeleteButtonItem(item:UIBarButtonItem)  {
           self.setBarButtonItem(item: item, size: 22)
       }

       //老师我的学习自定义
       static func setteacherStudyButtonItem(item:UIBarButtonItem)  {
           self.setBarButtonItem(item: item, size: 25)
       }
       static func setBarButtonItemSize(item:UIBarButtonItem,size:Int)  {
           self.setBarButtonItem(item: item, size: size)
       }
       
       //自定义 BarButtonItem
       static func setBarButtonItem(item:UIBarButtonItem,size:Int){
        item.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.Iconfont(size: CGFloat(size))], for:.normal)
        item.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.Iconfont(size: CGFloat(size))], for:.highlighted)
       }
}
