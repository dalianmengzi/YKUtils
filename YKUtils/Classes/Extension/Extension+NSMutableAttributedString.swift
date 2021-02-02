//
//  Extension+NSMutableAttributedString.swift
//  yktIcve
//
//  Created by 志辉教育 on 2019/10/18.
//  Copyright © 2019 zqyou. All rights reserved.
//

import UIKit

public extension NSMutableAttributedString{
    enum regexStr: String{
        case d = "\\d+" //匹配数字 [0-9]
        case W = "\\W" //匹配任意不是字母，数字，下划线，汉字的字符[^\w]
        case dW = "\\d|\\W"
        case hf = "回复"//匹配回复
        case tp = "[图片]"//匹配[图片]
        case m = "\\d+|/|-|:"//匹配数字 [0-9]以及:、- /
    }
    ///根据正则表达式改变文字颜色
    class func changeTextChange(regex: regexStr, text: String, color: UIColor) ->  NSMutableAttributedString{
        let attributeString = NSMutableAttributedString(string: text)
        do {
            let regexExpression = try NSRegularExpression(pattern: regex.rawValue, options: NSRegularExpression.Options())
            let result = regexExpression.matches(in: text, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, text.count))
            for item in result {
                attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: item.range)
                
            }
        } catch {
            print("Failed with error: \(error)")
        }
        return attributeString
    }
    ///根据正则表达式改变文字颜色以及字体大小
    class func changeTextStyle(regex: regexStr, text: String, color: UIColor,size:Int) ->  NSMutableAttributedString{
        let attributeString = NSMutableAttributedString(string: text)
        do {
            let regexExpression = try NSRegularExpression(pattern: regex.rawValue, options: NSRegularExpression.Options())
            let result = regexExpression.matches(in: text, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, text.count))
            for item in result {
                attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: item.range)
                attributeString.addAttribute(NSAttributedString.Key.font, value: UIFont.HelveticaNeue_Light(size: CGFloat(size)), range: item.range)
            }
        } catch {
            print("Failed with error: \(error)")
        }
        
        return attributeString
    }
    
    ///将传过来的文字颜色改变
    class func changeTextColor(changeText: String, text: String, color: UIColor) -> NSMutableAttributedString{
        
        let attributeString = NSMutableAttributedString(string: text)
        
        do {
            let regexExpression = try NSRegularExpression(pattern: changeText, options: NSRegularExpression.Options())
            let result = regexExpression.matches(in: text, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, text.count))
            for item in result {
                attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: item.range)
            }
        } catch {
            print("Failed with error: \(error)")
        }
        
        return attributeString
    }
}
