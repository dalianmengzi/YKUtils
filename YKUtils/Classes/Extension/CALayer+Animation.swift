//
//  CALayer+Animation.swift
//  QQMusic
//
//  Created by 杜帅 on 16/10/14.
//  Copyright © 2016年 杜帅. All rights reserved.
//

import Foundation
import UIKit
public extension CALayer {
    /* 暂停动画 */
    func pauseAnimation() {
        let pauseTime : CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0.0
        timeOffset = pauseTime
    }
    /* 继续动画 */
    func resumeAnimation() {
        let pauseTime : CFTimeInterval = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let timeSincePause : CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil) - pauseTime
        beginTime = timeSincePause
    }


    /// 晃动效果
    func shake() {
        let kfa = CAKeyframeAnimation.init(keyPath: "transform.translation.x")
        let s:CGFloat = 5.0


        kfa.values = [(-s),(0),s,0,-s,0,s,0]

        //晃动时长
        kfa.duration = 0.3

        //重复次数
        kfa.repeatCount = 2

        //移除
        kfa.isRemovedOnCompletion = true

        add(kfa, forKey: "shake")

    }

    /// 带重力效果的弹跳
    func jump(){

          let animation = CAKeyframeAnimation.init(keyPath: "transform.translation.y")

            //几次上下跳动 的Y轴位置
            animation.values = [0.0,-4.15,-7.26,-9.34,-10.37,-9.34,-7.26,-4.15,0.0,
                 2.0,-2.9,-4.94,-6.11,-6.42,-5.86,-4.44,-2.16,0.0]
            animation.duration = 0.8

            add(animation, forKey: "jump")

    }
}
