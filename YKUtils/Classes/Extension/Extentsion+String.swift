//
//  extentsionString.swift
//  云课堂2
//
//  Created by 志辉教育 on 2018/6/6.
//  Copyright © 2018年 zqyou. All rights reserved.
//


import UIKit
import MobileCoreServices
import SystemConfiguration.CaptiveNetwork
import CoreLocation
import CommonCrypto
public extension String {

    ///（如果backwards参数设置为true，则返回最后出现的位置）
    func positionOf(sub:String, backwards:Bool = false)->Int {
        // 如果没有找到就返回-1
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }

    /// 使用下标截取字符串 例: "示例字符串"[0..<2] 结果是 "示例"
    subscript (r: Range<Int>) -> String {
        get {
          
            if (r.lowerBound > count) || (r.upperBound > count) { return "截取超出范围" }
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }

    /// 截取第一个到第任意位置
    ///
    /// - Parameter end: 结束的位值
    /// - Returns: 截取后的字符串
    func stringCut(end: Int) ->String{

        if !(end < self.count) { return "截取超出范围" }
        let sInde = index(startIndex, offsetBy: end)
        return String(self[...sInde])
    }


    /// 截取第任意位置到结束
    ///
    /// - Parameter end:
    /// - Returns: 截取后的字符串
    func stringCutToEnd(start: Int) -> String {
        if !(start < count) { return "截取超出范围" }
        let sRang = index(startIndex, offsetBy: start)
        //return substring(with: sRang)
        return String(self[sRang...])
    }

    /// 字符串任意位置插入
    ///
    /// - Parameters:
    ///   - content: 插入内容
    ///   - locat: 插入的位置
    /// - Returns: 添加后的字符串
    func stringInsert(content: String,locat: Int) -> String {
        if !(locat < count) { return "截取超出范围" }
        let str1 = stringCut(end: locat)
        let str2 = stringCutToEnd(start: locat+1)
        return str1 + content + str2
    }
    //Unicode转码
    func unicodeStr() -> String {
        let tempStr1 = self.replacingOccurrences(of: "\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tempStr3 = "\"".appending(tempStr2).appending("\"")
        let tempData = tempStr3.data(using: String.Encoding.utf8)
        var returnStr:String = ""
        do {
            returnStr = try PropertyListSerialization.propertyList(from: tempData!, options: [.mutableContainers], format: nil) as! String
        } catch {
            print(error)
        }
        return returnStr.replacingOccurrences(of: "\\r\\n", with: "\n")
    }
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }

    /// range转换为NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }


    func widthWithLimit(_ size:CGSize, font:UIFont) -> CGFloat {
        return sizeWithLimit(size, font: font).width
    }

    func heightWithLimit(_ size:CGSize, font:UIFont) -> CGFloat {
        return sizeWithLimit(size, font: font).height
    }

    func sizeWithLimit(_ size:CGSize, font:UIFont) -> CGSize {
        guard self.count > 0 else {
            return CGSize.zero
        }
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
        return rect.size
    }
    /// 返回字数
    var count: Int {
        let string_NS = self as NSString
        return string_NS.length
    }

    /// 判断是否为空(去除前后空格和换行)
    var isBlank: Bool {
        return trimmingCharacters(in: .whitespaces).trimmingCharacters(in: .newlines).isEmpty
    }
    ///使用正则表达式替换
    func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
    var length: Int {
        return self.count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
      
        return self[0 ..< max(0, toIndex)]
    }
    

    ///去掉字符串标签
    mutating func filterHTML() -> String?{
        let scanner = Scanner(string: self)
        var text: NSString?
        while !scanner.isAtEnd {
            scanner.scanUpTo("<", into: nil)
            scanner.scanUpTo(">", into: &text)
            self = self.replacingOccurrences(of: "\(text == nil ? "" : text!)>", with: "")
        }
        return self
    }
    //过滤html标签
    func conversionHTML() -> String{
        let pattern = "[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]|&nbsp;"
        let text = self.pregReplace(pattern: pattern, with: "")
        return text
    }
    
    
    ///获取第一个字母
    func firstString()->String{
        if self.count < 1 {
            return " "
        }else{
            let index = (self as NSString).character(at: 0)
            if( index > 0x4e00 && index < 0x9fff)
            {
                return self.getLetter()
            }else{
                let index = self.startIndex
                let firstString = String.init(self[index])
                return firstString.uppercased()
            }
            
        }
        
    }
    
    //根据汉子获取首字母
    func getLetter() -> String {
        
        if !self.isBlank{
            var ms:NSMutableString? = NSMutableString.init(string: self)
            
            CFStringTransform(ms, UnsafeMutablePointer.init(bitPattern: 0), kCFStringTransformMandarinLatin, false)
            CFStringTransform(ms, UnsafeMutablePointer.init(bitPattern: 0), kCFStringTransformStripDiacritics, false)
            
            var pyArr:[String]? = ms?.components(separatedBy: " ")
            if pyArr != nil && (pyArr?.count)! > 0 {
                
                let strResult = (pyArr![0] as NSString).substring(to: pyArr![0].count)
                
                return strResult.uppercased()
            }
            
            ms = nil
            pyArr = nil
        }
        return self
    }
    //根据汉子获取首字母,非字母处理
    func getSpecialLetter() -> String {
        
        if !self.isBlank{
            var ms:NSMutableString? = NSMutableString.init(string: self)
            
            CFStringTransform(ms, UnsafeMutablePointer.init(bitPattern: 0), kCFStringTransformMandarinLatin, false)
            CFStringTransform(ms, UnsafeMutablePointer.init(bitPattern: 0), kCFStringTransformStripDiacritics, false)
            
            var pyArr:[String]? = ms?.components(separatedBy: " ")
            if pyArr != nil && (pyArr?.count)! > 0 {
              
                let strResult = (pyArr![0] as NSString).substring(to: 1)
                //数字
                let pattern = "^[0-9]*$"
                //替换后的
                let str = strResult.pregReplace(pattern: pattern, with: "#")
                return str.uppercased()
            }
            ms = nil
            pyArr = nil
            
        }else{
            return "#"
        }
        return self
    }

    //MARK:- 正则仅匹配手机号11位
    func checkMobile11() -> Bool{

        let MOBIL = "^1\\d{10}$";
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", MOBIL)
        if regextestmobile.evaluate(with: self) {
            return true
        }
        return false
    }
    ///是否包含中文
    func isIncludeChineseIn() -> Bool {
        
        for (_, value) in self.enumerated() {
            
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        
        return false
    }
    //MARK:- 正则匹配手机号
//     func checkMobile() ->Bool
//    {
//        /**
//         * 手机号码
//         * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//         * 联通：130,131,132,152,155,156,185,186
//         * 电信：133,1349,153,180,189,181(增加)
//         */
//        let MOBIL = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//        /**
//         * 中国移动：China Mobile
//         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//         */
//        let CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
//        /**
//         * 中国联通：China Unicom
//         * 130,131,132,152,155,156,185,186
//         */
//        let CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$";
//        /**
//         * 中国电信：China Telecom
//         * 133,1349,153,180,189,181(增加)
//         */
//        let CT = "^1((33|53|8[019])[0-9]|349)\\d{7}$";
//        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", MOBIL)
//        let regextestcm = NSPredicate(format: "SELF MATCHES %@", CM)
//        let regextestcu = NSPredicate(format: "SELF MATCHES %@", CU)
//        let regextestct = NSPredicate(format: "SELF MATCHES %@", CT)
//        if regextestmobile.evaluate(with: self)||regextestcm.evaluate(with: self)||regextestcu.evaluate(with: self)||regextestct.evaluate(with: self) {
//            return true
//        }
//        return false
//    }
    //MARK:- 正则匹配用户身份证号15或18位
     func checkUserIdCard() ->Bool {
        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }
    //MARK:- 正则匹配用户密码8-32位数字和字母组合,去除特别字符密码由大写字母、小写字母、数字、特殊字符中任意三种组成，长度为 8-32 位 ，特殊字符为：!@#$%^&*()_+-=
    func checkPassword() -> Bool {
        var evaluateCont = 0;
        let numberOfCharacters = self.count
        //1.判断密码位数
        if numberOfCharacters  < 8 || numberOfCharacters > 32 {
            return false
        }
        
        //2.判断 大写字母 ^[A-Z]+$
        let letterRegexD:NSPredicate = NSPredicate(format: "SELF MATCHES %@", "^.*[A-Z]+.*$")
        if  letterRegexD.evaluate(with: self){
            evaluateCont = evaluateCont + 1
        }
        // 3.判断 小写 字母
        let letterRegex:NSPredicate = NSPredicate(format: "SELF MATCHES %@", "^.*[a-z]+.*$")
        if  letterRegex.evaluate(with: self){
            evaluateCont = evaluateCont + 1
        }
        // 3. 判断 数字
        let numberRegex:NSPredicate = NSPredicate(format: "SELF MATCHES %@", "^.*[0-9]+.*$")
        if numberRegex.evaluate(with: self){
            evaluateCont = evaluateCont + 1
        }
        // 4. 判断 特殊字符  !@#$%^&*()_+-=
        let customRegex:NSPredicate = NSPredicate(format: "SELF MATCHES %@", "^.*[@$!^%*&\\_\\+\\-\\=\\(\\)\\#\\!]+.*$")
        if self.checkSpecialCharacters() && !customRegex.evaluate(with: self){
            return false
        }else if self.checkSpecialCharacters() && customRegex.evaluate(with: self){
            evaluateCont = evaluateCont + 1
        }
        return evaluateCont > 2
    }
    //MARK:- 去除特殊字符
    func deleteSpecialCharacters() -> String {
        let pattern: String = "[^a-zA-Z0-9\u{4e00}-\u{9fa5}]"
        let express = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return express.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.count), withTemplate: "")
    }
    //MARK:- 正则匹配特殊字符
    func checkSpecialCharacters() -> Bool{
        let customRegex:NSPredicate = NSPredicate(format: "SELF MATCHES %@", "^.*[^a-zA-Z0-9\u{4e00}-\u{9fa5}]+.*$")
        if customRegex.evaluate(with: self){
            return true
        }else{
            return false
        }
    }
    
    //MARK:- 正则匹配数字和字母组合
    func checkUserNumber() ->Bool{
        let pattern = "[a-zA-Z0-9]*"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }
  
    
    //MARK:- 正则匹配URL
     func checkURL() ->Bool {
        let pattern = "^[0-9A-Za-z]{1,50}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }
    //MARK:- 正则匹配用户姓名,8-20位的英文,数字
     func checkUserName() ->Bool {
        let pattern = "^[a-zA-Z0-9]{8,20}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }
    //MARK:- 正则匹配用户email
     func checkEmail() ->Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }

    //MARK:- 正则匹配保留两位小数
    func checkNumberF2() ->Bool {
        let pattern = "[0-9]+(.[0-9]{1,2})"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }
    //MARK:- 正则匹配小于100保留两位小数
    func checkNumberLess100F2() ->Bool {

        let pattern = "100|100.00|([0-9]{1,2}+(.[0-9]{1,2}))|([0-9]{1,2})"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }

    //MARK:- 正则匹配整数
    func checkNumber() ->Bool {
        let pattern = "^[0-9]*$"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }

    //MARK:- 正则匹配小于某个整数
    func checkLessThanNumber(_ num :Int) ->Bool {
        let pattern = "^[0-\(num)]$"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }

    //MARK:- 正则匹配QQ
    func checkQQ() ->Bool {
        let pattern = "[1-9][0-9]{4,14}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }


     //MARK:- 正则是否有换行
    func check_newline() -> Bool{
        let pattern = "\\s"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }


    //MARK:-
    func check_emoji() -> Bool{
        let pattern =  "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u2000-\\u201f\r\n]"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
         return isMatch;
    }
    //判断Emoji表情
    func containsEmoji()-> Bool {
           for scalar in unicodeScalars {
               switch scalar.value {
               case 0x1F600...0x1F64F, // Emoticons
                    0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                    0x1F680...0x1F6FF, // Transport and Map
                    0x2600...0x26FF,   // Misc symbols
                    0x2700...0x27BF,   // Dingbats
                    0xFE00...0xFE0F,   // Variation Selectors
                    0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                    0x1F1E6...0x1F1FF: // Flags
                    return true
               default:
                   continue
               }
           }
           return false
       }


    //MARk:中文、英文、数字包括下划线
    func check_zh ()-> Bool{
        let pattern =  "^[\\u4E00-\\u9FA5A-Za-z0-9_]+$"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
         print(isMatch)
        return isMatch;

    }



     //MARk:可以输入含有^%&',;=?$\”等字符
    func  check_special()-> Bool{
        let pattern = "[~!/@#$%^&#$%^&amp;*()-_=+\\|[{}];:\'\",&#$%^&amp;*()-_=+\\|[{}];:\'\",&lt;.&#$%^&amp;*()-_=+\\|[{}];:\'\",&lt;.&gt;/?]+"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        
        return isMatch;
    }

     //MARK:根据后缀获取对应的Mime-Type
    func mimeType() -> String {
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                           self as NSString,
                                                           nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?
                .takeRetainedValue() {
                return mimetype as String
            }
        }
        //文件资源类型如果不知道，传万能类型application/octet-stream，服务器会自动解析文件类
        return "application/octet-stream"
    }


    /// 返回相应的DateFormatter
    ///
    /// - Returns:
    func dateFormatter()-> DateFormatter{

        let formatter = DateFormatter()
        formatter.dateFormat = self
        return formatter
    }


    //获取文件大小
    func getSize()->UInt64
    {
        var fileSize : UInt64 = 0
        do {
            let attr = try FileManager.default.attributesOfItem(atPath:self)
            fileSize = attr[FileAttributeKey.size] as! UInt64

            let dict = attr as NSDictionary
            fileSize = dict.fileSize()
        } catch {
            print("Error: \(error)")
        }

        return fileSize
    }

    //md5加密
    var md5: String
       {
           let ccharArray = self.cString(using: String.Encoding.utf8)
       
           var uint8Array = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
           
           CC_MD5(ccharArray, CC_LONG(ccharArray!.count - 1), &uint8Array)
           
           return uint8Array.reduce("") { $0 + String(format: "%02X", $1)}
       }


    /// swift Base64处理

    /**

     *   编码

     */

    func base64Encoding()->String

    {

        let plainData = self.data(using: String.Encoding.utf8)

        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))

        return base64String!

    }

    /**

     *   解码

     */

    func base64Decoding()->String

    {

        let decodedData = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions.init(rawValue: 0))

        let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)! as String

        return decodedString

    }



    /// 获取Wi-Fi名称
    func getwifiName()->String{

        var wifiName : String = ""
        let wifiInterfaces = CNCopySupportedInterfaces()
        if wifiInterfaces == nil {
           return ""
        }

        let interfaceArr = CFBridgingRetain(wifiInterfaces!) as! Array<String>
        if interfaceArr.count > 0 {
            let interfaceName = interfaceArr[0] as CFString
            let ussafeInterfaceData = CNCopyCurrentNetworkInfo(interfaceName)

            if (ussafeInterfaceData != nil) {
                let interfaceData = ussafeInterfaceData as! Dictionary<String, Any>
                wifiName = interfaceData["SSID"]! as! String
            }
        }
        return wifiName
    }


    //是否开启定位权限
    func IsOpenLocation() -> Bool{
        let authStatus = CLLocationManager.authorizationStatus()
        return authStatus != .restricted && authStatus != .denied
    }
    
    //根据宽度返回占位的空格字符串
    func whitespaceString(font: UIFont = UIFont.systemFont(ofSize: 15), width: CGFloat) -> String {
        let kPadding: CGFloat = 20
        let mutable = NSMutableString(string: "")
        let attribute = [NSAttributedString.Key.font: font]
        while mutable.size(withAttributes: attribute).width < width - (2 * kPadding) {
            mutable.append(" ")
        }
        return mutable as String
    }
    ///判断是否为数字
    func isPurnInt() -> Bool {

        let scan: Scanner = Scanner(string: self)

        var val:Int = 0

        return scan.scanInt(&val) && scan.isAtEnd

    }
    //小数点后两位
    static func decimalPoint(number:Float)->String{
        var m:String = ""
        m = String(format: "%.2f", number)
        return m
    }
    //根据字符串url返回参数
    func StringReturnParameter()->[Dictionary<String,String>]{
        var dict = [Dictionary<String,String>]()
        guard let url = URL.init(string: self)else{
            return dict
        }
        dict = url.UrlReturnParameter()
        return dict
    }
    //去除html标签符号
    func removeHtmlSymbol()->String{
        return self.replacingOccurrences(of: "<[^>]+>|&nbsp", with: "", options: .regularExpression, range: nil)
    }

    
    //MARK: -时间戳转时间函数
    static func timeStampToString(timeStamp: String)->String {
        let time1 = Float(timeStamp) ?? 0.0
        
        let time2 = Int(time1)
        ///天
        let days = Int(time2/(3600*24))
        ///时
        let hours = Int((time2 - days*24*3600)/3600)
        ///分
        let minute = Int((time2 - days*24*3600-hours*3600)/60)
        ///秒
        let second = Int((time2 - days*24*3600-hours*3600) - 60*minute)
        var timeString:String = ""
        if hours == 0 && minute == 0{
            timeString = "\(second)秒"
        }else if hours == 0 && minute != 0{
            timeString = "\(minute)分\(second)秒"
        }else if hours != 0{
            timeString = "\(hours)时\(minute)分\(second)秒"
        }else{
            timeString = "\(second)秒"
        }
        return timeString
    }

}
