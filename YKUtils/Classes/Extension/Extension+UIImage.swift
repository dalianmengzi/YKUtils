//
//  extensionUIImage.swift
//  云课堂2
//
//  Created by 尤增强 on 2018/5/31.
//  Copyright © 2018年 zqyou. All rights reserved.
//

import UIKit
import Photos

public extension UIImage{


    /// PHAsset 生产图片
    ///
    /// - Parameter asset: asset
    /// - Returns: UIImage
  class  func PHAssetToImage(_ asset:PHAsset) -> UIImage{
        var image = UIImage()

        // 新建一个默认类型的图像管理器imageManager
        let imageManager = PHImageManager.default()

        // 新建一个PHImageRequestOptions对象
        let imageRequestOption = PHImageRequestOptions()

        // PHImageRequestOptions是否有效
        imageRequestOption.isSynchronous = true

        // 缩略图的压缩模式设置为无
        imageRequestOption.resizeMode = .none

        // 缩略图的质量为高质量，不管加载时间花多少
        imageRequestOption.deliveryMode = .highQualityFormat

        // 按照PHImageRequestOptions指定的规则取出图片
        imageManager.requestImage(for: asset, targetSize: CGSize.init(width: 1080, height: 1920), contentMode: .aspectFill, options: imageRequestOption, resultHandler: {
            (result, _) -> Void in
            image = result!
        })
        return image

    }



    /// PHAsset数组返回image 数组
    ///
    /// - Parameter assets: PHAsset 数组
    /// - Returns: image 数组
   class func PHAssetToImages(_ assets:[PHAsset]) -> [UIImage]{

        var images = [UIImage]()
        for asset in assets{
            // 新建一个默认类型的图像管理器imageManager
            let imageManager = PHImageManager.default()

            // 新建一个PHImageRequestOptions对象
            let imageRequestOption = PHImageRequestOptions()

            // PHImageRequestOptions是否有效
            imageRequestOption.isSynchronous = true

            // 缩略图的压缩模式设置为无
            imageRequestOption.resizeMode = .none

            // 缩略图的质量为高质量，不管加载时间花多少
            imageRequestOption.deliveryMode = .highQualityFormat

            // 按照PHImageRequestOptions指定的规则取出图片
            imageManager.requestImage(for: asset, targetSize: CGSize.init(width: 1080, height: 1920), contentMode: .aspectFill, options: imageRequestOption, resultHandler: {
                (result, _) -> Void in
                if let image =  result{
                    images.append(image)
                }
            })
        }
        return images

    }
    //MARK: - base64转图片
    class func Base64StringToUIImage(base64String:String)->UIImage? {
        var str = base64String
        // 1、判断用户传过来的base64的字符串是否是以data开口的，如果是以data开头的，那么就获取字符串中的base代码，然后在转换，如果不是以data开头的，那么就直接转换
        if str.hasPrefix("data:image"){
            guard let newBase64String = str.components(separatedBy: ",").last else{
                return nil
            }
            str = newBase64String
        }
        // 2、将处理好的base64String代码转换成NSData
        guard let imgNSData = NSData(base64Encoded: str, options: NSData.Base64DecodingOptions()) else {
            return nil
        }
        // 3、将NSData的图片，转换成UIImage
        guard let codeImage = UIImage(data: imgNSData as Data) else {
            return nil
        }
        return codeImage
    }
    
    //MARK: - 颜色生成图片
    class func produceImageWithColor(color:UIColor,rect:CGRect)->UIImage{
       
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
  
    //MARK: - 截屏的功能
    class func snapView(targetView: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(targetView.bounds.size, false, 0)
        // iOS7.0 之后系统提供的截屏的功能
        targetView.drawHierarchy(in: targetView.bounds, afterScreenUpdates: false)
        let snapdImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapdImage!
    }
    //MARK: - 截屏的功能
    class func screenSnapshot(save: Bool) -> UIImage? {
        
        guard let window = UIApplication.shared.keyWindow else { return nil }
        
        // 用下面这行而不是UIGraphicsBeginImageContext()，因为前者支持Retina
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, 0.0)
        
        window.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        if save { UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil) }
        
        return image
    }
    


    /// 获取视频封面
   class func getVideoCover(_ filePath:String) -> UIImage{

        let videoURL = NSURL.init(fileURLWithPath: filePath)
        let avAsset = AVAsset.init(url: videoURL as URL)
        //生成视频截图
        let generator = AVAssetImageGenerator(asset: avAsset)
        generator.appliesPreferredTrackTransform = true
    let time = CMTimeMakeWithSeconds(0.0,preferredTimescale: 600)
    var actualTime:CMTime = CMTimeMake(value: 0,timescale: 0)
        if let imageRef:CGImage = try? generator.copyCGImage(at: time, actualTime: &actualTime){
            let frameImg = UIImage.init(cgImage: imageRef)
            return frameImg
        }else{
            return #imageLiteral(resourceName: "default_slider_img")
        }
    }




    /**
     根据坐标获取图片中的像素颜色值
     */
    subscript (x: Int, y: Int) -> UIColor? {

        if x < 0 || x > Int(size.width) || y < 0 || y > Int(size.height) {
            return nil
        }

        let provider = self.cgImage!.dataProvider
        let providerData = provider!.data
        let data = CFDataGetBytePtr(providerData)

        let numberOfComponents = 4
        let pixelData = ((Int(size.width) * y) + x) * numberOfComponents

        let r = CGFloat(data![pixelData]) / 255.0
        let g = CGFloat(data![pixelData + 1]) / 255.0
        let b = CGFloat(data![pixelData + 2]) / 255.0
        let a = CGFloat(data![pixelData + 3]) / 255.0

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    
    
    /// 根据尺寸重新生成图片
     ///
     /// - Parameter size: 设置的大小
     /// - Returns: 新图
     public func imageWithNewSize(size: CGSize) -> UIImage? {
     
         if self.size.height > size.height {
             
             let width = size.height / self.size.height * self.size.width
             
             let newImgSize = CGSize(width: width, height: size.height)
             
             UIGraphicsBeginImageContext(newImgSize)
             
             self.draw(in: CGRect(x: 0, y: 0, width: newImgSize.width, height: newImgSize.height))
             
             let theImage = UIGraphicsGetImageFromCurrentImageContext()
             
             UIGraphicsEndImageContext()
             
             guard let newImg = theImage else { return  nil}
             
             return newImg
             
         } else {
             
             let newImgSize = CGSize(width: size.width, height: size.height)
             
             UIGraphicsBeginImageContext(newImgSize)
             
             self.draw(in: CGRect(x: 0, y: 0, width: newImgSize.width, height: newImgSize.height))
             
             let theImage = UIGraphicsGetImageFromCurrentImageContext()
             
             UIGraphicsEndImageContext()
             
             guard let newImg = theImage else { return  nil}
             
             return newImg
         }
     
     }
   
}

