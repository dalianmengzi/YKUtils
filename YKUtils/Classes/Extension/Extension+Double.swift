//
//  extensionDoudle.swift
//  yktIcve
//
//  Created by 尤增强 on 2018/11/26.
//  Copyright © 2018 zqyou. All rights reserved.
//

import UIKit

public extension Double{

    //时间秒转分
    func YFormatting()->String{
        if self.isNaN{
            print("=======================\(self)")
            return "0:00"
        }
        
        if let currentTime:Int = Int(self) {
            let minutes = currentTime / 60
            let seconds = currentTime - minutes * 60

            return NSString(format: "%02d:%02d", minutes,seconds) as String
        }else{
            return "0:00"
        }
    }
    
       //unit 转换
      func YFormatFileSize() -> String{
          var strSize = "0 B", i = 0,size = self;
          let unit = ["B","KB","M","G"];

          if(self > 0){
              while size / 1024 >= 1
              {
                  size =  size / 1024;
                  i  = i + 1;
              }
              strSize = "\(String(format: "%.1f", size) )\(unit[i])";
          }
          return strSize;
      }

      //unit 转换 以M 为单位
      func YFormatFileSizeM() -> String{
          var strSize = "0 M";
          let unit = self / 1024 / 1024
          strSize = "\(String(format: "%.2f", unit) )M";

          return strSize;
      }

}
