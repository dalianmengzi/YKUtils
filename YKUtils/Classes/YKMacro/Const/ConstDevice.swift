//
//  ConstDevice.swift
//  yktIcve
//
//  Created by 尤增强 on 2019/6/3.
//  Copyright © 2019 zqyou. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork


///MARK: ipad判断
let kIsIpad = UIDevice.current.model == "iPad" ? true : false

///MARK:取当前屏幕高度
let kScreenHeight = UIScreen.main.bounds.size.height ;
  
///MARK:取当前屏幕宽度
let kScreenWidth = UIScreen.main.bounds.size.width ;

///MARK:取当前App名称
let kAppDisplayName =  Bundle.main.infoDictionary != nil ? Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String :""

///MARK: 取当前版本号
let kCurrentVersion = Bundle.main.infoDictionary != nil ? Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String:""

///MARK: 取iOS版本
let kIosVersion = UIDevice.current.systemVersion


///MARK: 取当前手机IP地址
var kIpAddress: String {
    var addresses = [String]()
    var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
    if getifaddrs(&ifaddr) == 0 {
        var ptr = ifaddr
        while (ptr != nil) {
            let flags = Int32(ptr!.pointee.ifa_flags)
            var addr = ptr!.pointee.ifa_addr.pointee
            if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                        if let address = String(validatingUTF8:hostname) {
                            addresses.append(address)
                        }
                    }
                }
            }
            ptr = ptr!.pointee.ifa_next
        }
        freeifaddrs(ifaddr)
    }
    return addresses.first ?? "0.0.0.0"
}





// 获取当前wifi的IP地址
 var kWiFiIPAddress :String {
    var address: String = ""

    // get list of all interfaces on the local machine
    var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
    guard getifaddrs(&ifaddr) == 0 else {
        return ""
    }
    guard let firstAddr = ifaddr else {
        return ""
    }
    for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {

        let interface = ifptr.pointee

        // Check for IPV4 or IPV6 interface
        let addrFamily = interface.ifa_addr.pointee.sa_family
        if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
            // Check interface name
            let name = String(cString: interface.ifa_name)
            if name == "en0" {

                // Convert interface address to a human readable string
                var addr = interface.ifa_addr.pointee
                var hostName = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len), &hostName, socklen_t(hostName.count), nil, socklen_t(0), NI_NUMERICHOST)
                address = String(cString: hostName)
            }
        }
    }

    freeifaddrs(ifaddr)
    return address
}
// 获取手机具体型号
var kDeviceModel :String {
    var systemInfo = utsname()
    uname(&systemInfo)

    let platform = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
        return String(cString: ptr)
    }
    
    
    if platform == "iPhone1,1" { return "iPhone 2G"}
    if platform == "iPhone1,2" { return "iPhone 3G"}
    if platform == "iPhone2,1" { return "iPhone 3GS"}
    if platform == "iPhone3,1" { return "iPhone 4"}
    if platform == "iPhone3,2" { return "iPhone 4"}
    if platform == "iPhone3,3" { return "iPhone 4"}
    if platform == "iPhone4,1" { return "iPhone 4S"}
    if platform == "iPhone5,1" { return "iPhone 5"}
    if platform == "iPhone5,2" { return "iPhone 5"}
    if platform == "iPhone5,3" { return "iPhone 5C"}
    if platform == "iPhone5,4" { return "iPhone 5C"}
    if platform == "iPhone6,1" { return "iPhone 5S"}
    if platform == "iPhone6,2" { return "iPhone 5S"}
    if platform == "iPhone7,1" { return "iPhone 6 Plus"}
    if platform == "iPhone7,2" { return "iPhone 6"}
    if platform == "iPhone8,1" { return "iPhone 6S"}
    if platform == "iPhone8,2" { return "iPhone 6S Plus"}
    if platform == "iPhone8,4" { return "iPhone SE"}
    if platform == "iPhone9,1" { return "iPhone 7"}
    if platform == "iPhone9,2" { return "iPhone 7 Plus"}
    if platform == "iPhone10,1" { return "iPhone 8"}
    if platform == "iPhone10,2" { return "iPhone 8 Plus"}
    if platform == "iPhone10,3" { return "iPhone X"}
    if platform == "iPhone10,4" { return "iPhone 8"}
    if platform == "iPhone10,5" { return "iPhone 8 Plus"}
    if platform == "iPhone10,6" { return "iPhone X"}
    if platform == "iPhone11,2" { return "iPhone XS"}
    if platform == "iPhone11,4" { return "iPhone XS Max (China)"}
    if platform == "iPhone11,6" { return "iPhone XS Max (China)"}
    if platform == "iPhone11,8" { return "iPhone XR"}
    if platform == "iPhone12,1" { return "iPhone 11"}
    if platform == "iPhone12,3" { return "iPhone 11 Pro"}
    if platform == "iPhone12,5" { return "iPhone 11 Pro Max"}

    if platform == "iPod1,1" { return "iPod Touch 1G"}
    if platform == "iPod2,1" { return "iPod Touch 2G"}
    if platform == "iPod3,1" { return "iPod Touch 3G"}
    if platform == "iPod4,1" { return "iPod Touch 4G"}
    if platform == "iPod5,1" { return "iPod Touch 5G"}

    if platform == "iPad1,1" { return "iPad 1"}
    if platform == "iPad2,1" { return "iPad 2"}
    if platform == "iPad2,2" { return "iPad 2"}
    if platform == "iPad2,3" { return "iPad 2"}
    if platform == "iPad2,4" { return "iPad 2"}
    if platform == "iPad2,5" { return "iPad Mini 1"}
    if platform == "iPad2,6" { return "iPad Mini 1"}
    if platform == "iPad2,7" { return "iPad Mini 1"}
    if platform == "iPad3,1" { return "iPad 3"}
    if platform == "iPad3,2" { return "iPad 3"}
    if platform == "iPad3,3" { return "iPad 3"}
    if platform == "iPad3,4" { return "iPad 4"}
    if platform == "iPad3,5" { return "iPad 4"}
    if platform == "iPad3,6" { return "iPad 4"}
    if platform == "iPad4,1" { return "iPad Air"}
    if platform == "iPad4,2" { return "iPad Air"}
    if platform == "iPad4,3" { return "iPad Air"}
    if platform == "iPad4,4" { return "iPad Mini 2"}
    if platform == "iPad4,5" { return "iPad Mini 2"}
    if platform == "iPad4,6" { return "iPad Mini 2"}
    if platform == "iPad4,7" { return "iPad Mini 3"}
    if platform == "iPad4,8" { return "iPad Mini 3"}
    if platform == "iPad4,9" { return "iPad Mini 3"}
    if platform == "iPad5,1" { return "iPad Mini 4"}
    if platform == "iPad5,2" { return "iPad Mini 4"}
    if platform == "iPad5,3" { return "iPad Air 2"}
    if platform == "iPad5,4" { return "iPad Air 2"}
    if platform == "iPad6,3" { return "iPad Pro 9.7"}
    if platform == "iPad6,4" { return "iPad Pro 9.7"}
    if platform == "iPad6,7" { return "iPad Pro 12.9"}
    if platform == "iPad6,8" { return "iPad Pro 12.9"}

    if platform == "i386"   { return "iPhone Simulator"}
    if platform == "x86_64" { return "iPhone Simulator"}
    
    return platform
}
//是否是模拟器
var kIsSimulator :Bool {
    var isSim = false
    #if arch(i386) || arch(x86_64)
        isSim = true
    #endif
    return isSim
}
///获取连接路由IP
var kPublicIP:String{
    var ipAddress:String = ""
    if let url = URL(string: "http://pv.sohu.com/cityjson?ie=utf-8") , let s = try? String(contentsOf: url, encoding: String.Encoding.utf8) {
        let subArr = s.components(separatedBy: ":")
        if subArr.count > 1  {
            let ipStr = subArr[1].replacingOccurrences(of: "\"", with: "")
            let ipSubArr = ipStr.components(separatedBy: ",")
            if ipSubArr.count > 0 {
                let ip = ipSubArr[0]
                ipAddress = ip.trimmingCharacters(in: .whitespaces)
            }
        }
    }
    return ipAddress
}
///判断设备是否越狱
var kIsJailBroken:Bool {
 //判断设备上是否安装了这些程序
 let apps = ["/APPlications/Cydia.app",
             "/APPlications/limera1n.app",
             "/APPlications/greenpois0n.app",
             "/APPlications/blackra1n.app",
             "/APPlications/blacksn0w.app",
             "/APPlications/redsn0w.app",
             "/APPlications/Absinthe.app",
             "/private/var/lib/apt/"]
    for app in apps {
        //通过文件管理器，判断在指定的目录下，是否在对应的应用程序。如果存在的话。就表示当前设备为越狱设备。
        if FileManager.default.fileExists(atPath: app){
                return true
        }
    }
    return false
}

