//
//  Image.swift
//  ExMedia
//
//  Created by 王渊鸥 on 2018/7/28.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation
import UIKit
import ExDraw

public extension UIImage {
    func mask(color:UIColor) -> UIImage? {
        return UIGraphicsImageRenderer(bounds: CGRect(origin: CGPoint.zero, size: self.size)).image { (context) in
            if let cgimage = cgImage {
                UIGraphicsPushContext(context.cgContext)
                context.cgContext.draw(cgimage, in: CGRect(origin: CGPoint.zero, size: self.size))
                UIRectFillUsingBlendMode(CGRect(origin: CGPoint.zero, size: self.size), CGBlendMode.sourceAtop)
                UIGraphicsPopContext()
            }
        }
    }
    
    func blur(radius:CGFloat) -> UIImage? {
        return self.applyFilter({ (source) -> CIImage? in
            return source.apply(filter: ExFilter.gaussianBlur(radius: radius))
        })
    }
    
    func saveToPhotos() {
        UIImageWriteToSavedPhotosAlbum(self, nil, nil, nil)
    }
    
    func savePngFile(_ filename:String) -> Bool {
        return ((try? self.pngData()?.write(to: URL(fileURLWithPath: filename), options: [.atomic])) != nil)
    }
    
    func saveJpegFile(_ filename:String, quality:CGFloat = 0.75) -> Bool {
        return ((try? self.jpegData(compressionQuality: quality)?.write(to: URL(fileURLWithPath: filename), options: [.atomic])) != nil)
    }
}
