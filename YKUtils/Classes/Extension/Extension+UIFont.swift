//
//  extensionUIFont.swift
//  yktIcve
//
//  Created by cc on 2019/1/10.
//  Copyright © 2019年 zqyou. All rights reserved.
//

import UIKit

public extension UIFont {
    //FIXME:2.8.32 添加看护
    ///设置字体图标大小
    class func Iconfont(size : CGFloat) -> UIFont {
        guard let font = UIFont(name: "iconfont", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    ///设置HelveticaNeue-Light字体大小
    class func HelveticaNeue_Light(size : CGFloat) -> UIFont {
        guard let font = UIFont(name: "HelveticaNeue-Light", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
