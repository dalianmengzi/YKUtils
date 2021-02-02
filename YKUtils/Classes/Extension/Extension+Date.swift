//
//  Extension+Data.swift
//  yktIcve
//
//  Created by 志辉教育 on 2019/12/13.
//  Copyright © 2019 zqyou. All rights reserved.
//

import UIKit

public extension Date{
    ///MARK:时间戳判断
    func isTimeStamp() -> Bool {
        let m_isTimeStamp = Date().timeIntervalSince1970 < 1576382400
        return m_isTimeStamp
    }

    ///获取当前时间
    /// - Parameter dateFormat: 时间格式
    static  func YGetNowTime(_ dateFormat:String = "yyyyMMdd") -> String{
         let now = Date()
         let dformatter = DateFormatter()
         dformatter.dateFormat = dateFormat
//        dformatter.timeZone = TimeZone.init(abbreviation: )
         return dformatter.string(from: now)
    }
    
    
    /// 转换时间格式
    /// - Parameters:
    ///   - dateFormat: 时间格式
    ///   - dateStr: 需要转换的内容 String
    static func YDateFormatDate(dateFormat:String,dateStr:String)->Date?{
        let dformatter = DateFormatter()
        dformatter.dateFormat = dateFormat
        return dformatter.date(from: dateStr)
    }
    
    
    /// 转换时间格式
    /// - Parameters:
    ///   - dateFormat: 时间格式
    ///   - _date: 需要转换的时间-Date
    static func YDateFormatString(dateFormat:String,_date:Date)->String{
        let dformatter = DateFormatter()
        dformatter.dateFormat = dateFormat
        return dformatter.string(from: _date)
    }
    
    
    /// 获取时间
    ///
    /// - Returns: 时间戳
      static func YGetTimeStamp() -> Int{
           // 创建一个日期格式器
           let now = Date()
           //当前时间的时间戳
           let timeInterval:TimeInterval = now.timeIntervalSince1970
           let timeStamp = Int(timeInterval)
         
           return timeStamp
       }
    
    
    /// 获取星期几
    /// - Returns: 时间
    static func YGetWeekDay(dateTime:String)->Int{
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "yyyy-MM-dd"
        let date = dateFmt.date(from: dateTime)
        if date == nil{
            return 1
        }
        let interval = Int(date!.timeIntervalSince1970) + NSTimeZone.local.secondsFromGMT()
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
    ///当前时间比较(是否大于当地时间)
    static func isGreaterNowDate(dateTime:String,_ dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Bool{
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date( from: dateTime)
        guard let timeInterval = (date?.timeIntervalSince1970) else {
            return false
        }
        let nowTimeInterval = Date().timeIntervalSince1970
        return timeInterval > nowTimeInterval
    }
    //获取网络时间戳
    static func getNetworkDate()->String{
        let urlString = "https://m.baidu.com"
        guard let url = URL(string: urlString) else {
            return ""
        }
        var mResponse: HTTPURLResponse?

        let semaphare = DispatchSemaphore(value: 0) //使用信号量来同步请求
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            mResponse = response as? HTTPURLResponse
            semaphare.signal()
        }).resume()
        _ = semaphare.wait(timeout: DispatchTime.distantFuture) == .success ? 0 : -1
        guard let Response = mResponse else {
            return ""
        }
        let date = Response.allHeaderFields["Date"] as? String
        let datefmt = DateFormatter()
        datefmt.locale = Locale(identifier: "en_US")
        datefmt.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"

        let netDate = datefmt.date(from: date ?? "")
            
        guard let m_date = netDate else {
            return ""
        }
        return "\(Int(m_date.timeIntervalSince1970 * 1000))"
    }
    ///获取早中晚时辰
    static func getHourDate()->String{
        var hour:String = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        let str = formatter.string(from: Date())
        let time = Int(str) ?? 0
        if time >= 0 && time <= 5{
            hour = "凌晨"
        }else if time > 5 && time <= 8{
            hour = "早上"
        }else if time > 8 && time <= 11{
            hour = "上午"
        }else if time > 11 && time <= 13{
            hour = "中午"
        }else if time > 13 && time <= 18{
            hour = "下午"
        }else if time > 18 && time <= 24{
            hour = "晚上"
        }
        return hour
    }
    /// 获取当前 毫秒级 时间戳 - 13位
    static func milliStamp() -> String {
        let timeInterval: TimeInterval = Date().timeIntervalSince1970
     
        let millisecond = CLongLong(round(timeInterval*1000))
     
        return "\(millisecond)"
    }
}
