//
//  extensionUIColor.swift
//  云课堂2
//
//  Created by 尤增强 on 2018/5/22.
//  Copyright © 2018年 zqyou. All rights reserved.
//

import UIKit

public extension UIColor {


    /// 获取随机颜色
    ///
    /// - Returns: 随机颜色
    class func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
        let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        return UIColor(red:red, green:green, blue:blue , alpha: 1)
    }


    /// 通过 0x34e4e4 16进制获取颜色
    ///
    /// - Parameter hexColor:  16进制
    /// - Returns: 颜色
    class func colorWithHex(hexColor:Int64)->UIColor{

        return colorWithHex(hexColor: hexColor,alpha: 1);
    }


    /// 通过 Int64 获取颜色
    ///
    /// - Parameters:
    ///   - hexColor: 0x34e4e4 16进制
    ///   - alpha: 透明度
    /// - Returns: 颜色
    class func colorWithHex(hexColor:Int64,alpha:CGFloat)->UIColor{

        let red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0;
        let green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0;
        let blue = ((CGFloat)(hexColor & 0xFF))/255.0;

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)

    }

    class func colorWithRgba(_ r: CGFloat, g: CGFloat, b: CGFloat, a:CGFloat)-> UIColor {


        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)

    }

    static var bg = colorWithHex(hexColor: 0x28ac86)
    static var cg = colorWithHex(hexColor: 0x28ac86)
    
    ///获取反色
    func invertColor() -> UIColor {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: nil)
        return UIColor(red:1.0-r, green: 1.0-g, blue: 1.0-b, alpha: 1)
    }
}
