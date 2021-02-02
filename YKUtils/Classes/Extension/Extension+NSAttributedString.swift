//
//  extensionNSAttributedString.swift
//  yktIcve
//
//  Created by cc on 2019/1/28.
//  Copyright © 2019年 zqyou. All rights reserved.
//

import UIKit

public extension NSAttributedString{
    //富文本设置
    static func  setAttributeString(str:String, color:UIColor,fontSize:CGFloat,range:NSRange) -> NSAttributedString{
        let attributeString = NSMutableAttributedString(string:str)
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value:color,range: range)
        attributeString.addAttribute(NSAttributedString.Key.font, value: UIFont.Iconfont(size: fontSize), range: range)
        return attributeString
    }
    //富文本行间距
    static func setAttributeLine(text:String) -> NSAttributedString {
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing  = 5
        paraph.headIndent = 5
        paraph.firstLineHeadIndent = 5
        let attributes = [NSAttributedString.Key.font:UIFont.HelveticaNeue_Light(size: 14),
                          NSAttributedString.Key.paragraphStyle: paraph]
        return NSAttributedString(string: text,attributes: attributes)
    }
    //加载html
    static func loadHtml(str:String) -> NSAttributedString{
        
        
        //FIXME: 2.0.19后修改 改try!为 do catch
        do {
            let textHtml = try NSAttributedString(
            data: str.data(using: String.Encoding(rawValue: String.Encoding.unicode.rawValue), allowLossyConversion: true)!,
            options:[NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            return  textHtml
        } catch _ {
            return NSAttributedString.init()
        }
    
    }
    
    //设置富文本，图标(startSite:开始位置,endSite:结束位置,size:字体大小,bgColor:背景颜色,colorStr:字体颜色)
    static func setIconColor(str:String,colorStr:UIColor,startSite:Int,endSite:Int,size:Int,bgColor:UIColor) -> NSAttributedString{
        let attributeString = NSMutableAttributedString(string:str)
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: colorStr,
                                     range: NSMakeRange(startSite,endSite))
        attributeString.addAttribute(NSAttributedString.Key.backgroundColor, value: bgColor, range: NSMakeRange(startSite,endSite))
        attributeString.addAttribute(NSAttributedString.Key.font, value: UIFont.init(name: "iconfont", size: CGFloat(size))!, range: NSMakeRange(startSite,endSite))
        return attributeString
    }
}
