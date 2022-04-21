//
//  UIImage+Extension.swift
//  BSTimer
//
//  Created by 永瀬 on 2022/04/03.
//

import UIKit
extension UIImage {
    
    func rgb2GrayScale() -> UIImage? {
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        guard let context = CGContext(data: nil,
                                      width: Int(size.width),
                                      height: Int(size.height),
                                      bitsPerComponent: 8,
                                      bytesPerRow: 0,
                                      space: CGColorSpaceCreateDeviceGray(),
                                      bitmapInfo: CGImageAlphaInfo.none.rawValue),
              let cgImage = cgImage else {
                  
                  return nil
              }
        
        context.draw(cgImage, in: rect)
        guard let image = context.makeImage() else {
        
            return nil
        }
        
        guard let pngData = UIImage(cgImage: image).pngData() else { return nil }
        
        return UIImage(data: pngData)
    }
}
