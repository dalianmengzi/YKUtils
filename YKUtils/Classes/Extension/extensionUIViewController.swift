//
//  extensionUIViewController.swift
//  yktIcve
//
//  Created by cc on 2019/2/21.
//  Copyright © 2019年 zqyou. All rights reserved.
//

import UIKit

public extension UIViewController {
    //获取当前显示的视图控制器
    class func current(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return current(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return current(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return current(base: presented)
        }
        return base
    }
}
