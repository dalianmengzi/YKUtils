//
//  Array+extension.swift
//  yktIcve
//
//  Created by 尤增强 on 2019/3/28.
//  Copyright © 2019 zqyou. All rights reserved.
//

import UIKit

public extension Array {


    /// 移除某一个obj
    ///
    /// - Parameter obj: 被移除的项
    /// - Returns: 移除后的数据
    func removeObj <S:Equatable> (_ obj:S)->[S] {
        var items :[S]  = self as! [S]
        for  (index,value) in items.enumerated(){
            if value == obj { //如果没指定S：Equatable 这句话会编译不通过
                items.remove(at: index)
            }
        }
        return items
    }


}
