//
//  Extension+UIDevice.swift
//  yktIcve
//
//  Created by 尤增强 on 2020/4/28.
//  Copyright © 2020 zqyou. All rights reserved.
//

import UIKit
public extension UIDevice{
  
  func blankof<T>(type:T.Type) -> T {
    let ptr = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T>.size);
    let val = ptr.pointee;
    ptr.deinitialize(count: 1);
    return val;
  }
  
  /// 磁盘总大小
  var TotalDiskSize:Double{
    var fs = blankof(type: statfs.self)
    if statfs("/var",&fs) >= 0{
      return Double(UInt64(fs.f_bsize) * fs.f_blocks)
    }
    return -1
  }
  
  /// 磁盘可用大小
    var AvailableDiskSize:Double{
        //  Converted to Swift 5.3 by Swiftify v5.3.19197 - https://swiftify.com/
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).map(\.path)
        var dictionary: [FileAttributeKey : Any]? = nil
        do {
            dictionary = try FileManager.default.attributesOfFileSystem(forPath: paths.last ?? "")
        } catch {
        }
        if let dictionary = dictionary {
            let _free = dictionary[.systemFreeSize] as? NSNumber
            return Double(_free?.uint64Value ?? 0) * 1.0 / 1024
        } else {
            return -1
        }
    }
  
}
