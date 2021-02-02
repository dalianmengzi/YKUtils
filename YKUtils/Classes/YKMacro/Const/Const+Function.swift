//
//  Const+Function.swift
//  yktIcve
//
//  Created by 尤增强 on 2019/8/29.
//  Copyright © 2019 zqyou. All rights reserved.
//

import UIKit



func maxElement<T:Comparable>( _ seq:[T]) -> T{

  
    return seq.reduce(seq[0]){

        max($0, $1)
    }
}



func minElement<T:Comparable>( _ seq:[T]) -> T{

    return seq.reduce(seq[0]){

        min($0, $1)
    }
}

func DEBUGLog<T>(_ message:T, file:String = #file, function:String = #function,
                 line:Int = #line) {
    #if DEBUG
    //获取文件名
    let fileName = (file as NSString).lastPathComponent
    //打印日志内容
    print("\(fileName):\(line) \(function) | \(message)")
    #endif
}


