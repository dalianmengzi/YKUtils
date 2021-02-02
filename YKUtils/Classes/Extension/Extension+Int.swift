//
//  Extension+Int.swift
//  yktIcve
//
//  Created by 志辉教育 on 2019/10/18.
//  Copyright © 2019 zqyou. All rights reserved.
//

import UIKit

 public extension Int {
    /// 根据00:00:00时间格式，转换成秒
    func getSecondsFromTimeStr(timeStr:String) -> Int {
        if timeStr.isEmpty {
            return 0
        }
        let timeArry = timeStr.replacingOccurrences(of: "：", with: ":").components(separatedBy: ":")
        var seconds:Int = 0

        if timeArry.count > 0 && timeArry[0].isPurnInt(){
            let hh = Int(timeArry[0])
            if hh! > 0 {
                seconds += hh!*60*60
            }
        }
        if timeArry.count > 1 && timeArry[1].isPurnInt(){
            let mm = Int(timeArry[1])
            if mm! > 0 {
                seconds += mm!*60
            }
        }
        if timeArry.count > 2 && timeArry[2].isPurnInt(){
            let ss = Int(timeArry[2])
            if ss! > 0 {
                seconds += ss!
            }
        }
        return seconds
    }
    ///判断是否是奇数
    func isSingleNum() -> Bool{
        if self % 2 == 0{
            return false
        }else{
            return true
        }
    }
    ///获取月份天数
    func DaysCountForMonth(year: Int, month: Int) -> Int {
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            return 31
        case 4, 6, 9, 11:
            return 30
        case 2:
            let isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
            return isLeapYear ? 29 : 28
        default:
            fatalError("非法的月份:\(month)")
        }
    }
    //是否是倍数
    func isYMultiple(num:Int) -> Bool{
        return self % num == 0
    }
}
