//
//  UIView+CornerRadius.swift
//  yktIcve
//
//  Created by 志辉教育 on 2018/11/7.
//  Copyright © 2018年 zqyou. All rights reserved.
//

import UIKit
public extension UIView {

    @IBInspectable var _cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var _masksToBounds: Bool {
        get {
            return false
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue > 0 ? newValue : 0
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var _shadowOpacity: Float{
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var _shadowRadius: CGFloat{
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable var _shadowOffset: CGSize{
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var _shadowColor: UIColor{
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowPath: CGPath{
        get {
            return layer.shadowPath!
        }
        set {
            layer.shadowPath = newValue
        }
    }
    
}
