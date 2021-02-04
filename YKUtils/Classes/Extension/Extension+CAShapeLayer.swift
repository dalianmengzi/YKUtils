//
//  extensionCAShapeLayer.swift
//  yktIcve
//
//  Created by cc on 2019/1/31.
//  Copyright © 2019年 zqyou. All rights reserved.
//

import UIKit

extension CAShapeLayer{
    //画线
    static func drawline(lab:UILabel,width:CGFloat)->CAShapeLayer{
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        shapeLayer.bounds = lab.bounds
        shapeLayer.position = CGPoint(x: lab.frame.width / 2, y: lab.frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.colorWithHex(hexColor: 0x8F8F8F).cgColor
        shapeLayer.lineWidth = 0.3
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPhase = 0
        shapeLayer.lineDashPattern = [NSNumber(value: 4), NSNumber(value: 4)]
        let path:CGMutablePath = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width, y: 0))
        shapeLayer.path = path
        return shapeLayer
    }
    static func drawLableline(lab:UILabel,lineWidth:CGFloat,lineColor:UIColor,startPoint:CGPoint,endPoint:CGPoint,arr:Array<Any>)->CAShapeLayer{
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        shapeLayer.bounds = lab.bounds
        shapeLayer.position = CGPoint(x: lab.frame.width / 2, y: lab.frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPhase = 0
        if arr.count > 0{
            shapeLayer.lineDashPattern = arr as? [NSNumber]  //设置虚线,点与点之间的空隙
        }
        let path:CGMutablePath = CGMutablePath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        shapeLayer.path = path
        return shapeLayer
    }
    //画线
    static func drawTextFieldline(textField:UITextField,lineWidth:CGFloat,lineColor:UIColor,startPoint:CGPoint,endPoint:CGPoint,arr:Array<Any>)->CAShapeLayer{
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        shapeLayer.bounds = textField.bounds
        shapeLayer.position = CGPoint(x: textField.frame.width / 2, y: textField.frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPhase = 0
        if arr.count > 0{
            shapeLayer.lineDashPattern = arr as? [NSNumber]  //设置虚线,点与点之间的空隙
        }
        let path:CGMutablePath = CGMutablePath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        shapeLayer.path = path
        return shapeLayer
    }
    static func drawBtnline(_btn:UIButton,lineWidth:CGFloat,lineColor:UIColor,startPoint:CGPoint,endPoint:CGPoint,arr:Array<Any>)->CAShapeLayer{
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        shapeLayer.bounds = _btn.bounds
        shapeLayer.position = CGPoint(x: _btn.frame.width / 2, y: _btn.frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPhase = 0
        if arr.count > 0{
            shapeLayer.lineDashPattern = arr as? [NSNumber]  //设置虚线,点与点之间的空隙
        }
        let path:CGMutablePath = CGMutablePath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        shapeLayer.path = path
        return shapeLayer
    }
    
    static func drawUIViewline(_view:UIView,lineWidth:CGFloat,lineColor:UIColor,startPoint:CGPoint,endPoint:CGPoint,arr:Array<Any>)->CAShapeLayer{
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        shapeLayer.bounds = _view.bounds
        shapeLayer.position = CGPoint(x: _view.frame.width / 2, y: _view.frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPhase = 0
        if arr.count > 0{
            shapeLayer.lineDashPattern = arr as? [NSNumber]  //设置虚线,点与点之间的空隙
        }
        let path:CGMutablePath = CGMutablePath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        shapeLayer.path = path
        return shapeLayer
    }
}
