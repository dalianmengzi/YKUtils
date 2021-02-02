//
//  URL+extension.swift
//  yktIcve
//
//  Created by 尤增强 on 2019/3/1.
//  Copyright © 2019 zqyou. All rights reserved.
//

import UIKit
public extension URL{


    //获取文件大小
    func getSize()->UInt64
    {
        var fileSize : UInt64 = 0

        do {
            let attr = try FileManager.default.attributesOfItem(atPath: self.path)
            fileSize = attr[FileAttributeKey.size] as! UInt64

            let dict = attr as NSDictionary
            fileSize = dict.fileSize()
        } catch {
            print("Error: \(error)")
        }

        return fileSize
    }
    //Url返回参数
    func UrlReturnParameter()->[Dictionary<String,String>]{
        var dict = [Dictionary<String,String>]()
        guard let query = self.query else{
            return dict
        }
        
        let array = query.components(separatedBy: "&")
        for v in array{
            let arr = v.components(separatedBy: "=")
            let m = ["idType":arr.first ?? "",
                     "idContent":arr.last ?? ""]
            dict.append(m)
        }
        return dict
    }

   
}
