//
//  Extension+UITableview.swift
//  yktIcve
//
//  Created by 尤增强 on 2020/3/16.
//  Copyright © 2020 zqyou. All rights reserved.
//

import UIKit

public extension UITableView {
    
    //自定义暂无数据
    func setTableFootView_noData(_ _count:Int){
           let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: 300))
           let lab = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 300))
           lab.center = view.center
           lab.font = UIFont.init(name: "iconfont", size: 120);
           lab.textAlignment = .center
           lab.text = "\u{e752}"
           lab.textColor = UIColor.lightGray
           view.addSubview(lab);
           if(_count  == 0 ){
               self.tableFooterView  = view
           }else{
               self.tableFooterView =  UIView.init(frame: CGRect.zero)
           }
       }

}
