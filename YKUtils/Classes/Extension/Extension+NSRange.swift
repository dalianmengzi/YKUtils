//
//  extensionNSRange.swift
//  yktIcve
//
//  Created by 志辉教育 on 2018/9/7.
//  Copyright © 2018年 zqyou. All rights reserved.
//

import UIKit
//扩展NSRange，添加转换成Range的方法
public extension NSRange {
    func toRange(string: String) -> Range<String.Index> {
       
        let startIndex = string.index(string.startIndex, offsetBy: self.location)
        let endIndex = string.index(startIndex, offsetBy: self.length)
        return startIndex..<endIndex
    }
}
