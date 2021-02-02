//
//  Extension+UIButton.swift
//  yktIcve
//
//  Created by 志辉教育 on 2019/12/17.
//  Copyright © 2019 zqyou. All rights reserved.
//

import UIKit

public extension UIButton{
    ///返回按钮样式统一,颜色默认为白色
    func bindBackButton(_ color:UIColor = .white){
        self.setTitle("\u{e6f7}返回", for: .normal)
        self.titleLabel?.font = UIFont.Iconfont(size: 17)
        self.setTitleColor(color, for: .normal)
    }
}

