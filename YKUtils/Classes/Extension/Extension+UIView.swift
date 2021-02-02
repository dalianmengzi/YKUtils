//
//  Extension+UIView.swift
//  yktIcve
//
//  Created by 志辉教育 on 2019/7/1.
//  Copyright © 2019 zqyou. All rights reserved.
//

import UIKit

public extension UIView {
    
    ///设置阴影
    func setShadow(width:CGFloat,borderColor:UIColor,shadowColor:UIColor,offset:CGSize,opacity:Float,radius:CGFloat) {
        //设置视图边框宽度
        self.layer.borderWidth = width
        //设置边框颜色
        self.layer.borderColor = borderColor.cgColor
        //设置边框圆角
        self.layer.cornerRadius = radius
        //设置阴影颜色
        self.layer.shadowColor = shadowColor.cgColor
        //设置透明度
        self.layer.shadowOpacity = opacity
        //设置阴影半径
        self.layer.shadowRadius = radius
        //设置阴影偏移量
        self.layer.shadowOffset = offset
    }
    
    
    //返回该view所在的父view
    func superView<T: UIView>(of: T.Type) -> T? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let father = view as? T {
                return father
            }
        }
        return nil
    }


    var x: CGFloat {
        get {
            return self.frame.origin.x
        }

        set {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }

    var y: CGFloat {
        get {
            return self.frame.origin.y
        }

        set {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    ///通过view查找所在的ViewController
    func getViewControllerByView() -> UIViewController? {
          for view in sequence(first: self.superview, next: { $0?.superview }) {
              if let responder = view?.next {
                  if responder.isKind(of: UIViewController.self){
                      return responder as? UIViewController
                  }
              }
          }
          return nil
      }
    ///获取view上面某一点的颜色
    func pickColor(at position: CGPoint) -> UIColor? {
        
        // 用来存放目标像素值
        var pixel = [UInt8](repeatElement(0, count: 4))
        // 颜色空间为 RGB，这决定了输出颜色的编码是 RGB 还是其他（比如 YUV）
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        // 设置位图颜色分布为 RGBA
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
        guard let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo) else {
            return nil
        }
        // 设置 context 原点偏移为目标位置所有坐标
        context.translateBy(x: -position.x, y: -position.y)
        // 将图像渲染到 context 中
        layer.render(in: context)
        
        return UIColor(red: CGFloat(pixel[0]) / 255.0,
                       green: CGFloat(pixel[1]) / 255.0,
                       blue: CGFloat(pixel[2]) / 255.0,
                       alpha: CGFloat(pixel[3]) / 255.0)
    }
}
