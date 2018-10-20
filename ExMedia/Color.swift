//
//  Color.swift
//  ExMedia
//
//  Created by 王渊鸥 on 2018/7/27.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import UIKit
import ExType

public extension UIColor {
    public convenience init(hex:String) {
        let colorText = hex.hasPrefix("#") ? String(hex[hex.startIndex...]) : hex
        
        let red = Int(hex:colorText[0..<2])
        let green = Int(hex:colorText[2..<4])
        let blue = Int(hex:colorText[4..<6])
        
        if colorText.count > 6 {
            let alpha = Int(Float(Int(hex:colorText[6..<8])) / 2.55)
            self.init(RGBA: red, green, blue, alpha)
        } else {
            self.init(RGBA: red, green, blue)
        }
    }
    
    public convenience init(RGBA r:Int, _ g:Int, _ b:Int, _ a:Int = 100) {
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a)/100.0)
    }
    
    public convenience init(HSBA h:Int, _ s:Int, _ b:Int, _ a:Int = 100) {
        self.init(hue: CGFloat(h)/360.0, saturation: CGFloat(s)/100.0, brightness: CGFloat(b)/100.0, alpha: CGFloat(a)/100.0)
    }
    
    public var RGBA:(Int, Int, Int, Int) {
        var red:CGFloat = 0, green:CGFloat = 0, blue:CGFloat = 0, alpha:CGFloat = 0, white:CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return (Int(Double(red)*255.0), Int(Double(green)*255.0), Int(Double(blue)*255), Int(Double(alpha)*100.0))
        } else if self.getWhite(&white, alpha: &alpha) {
            let color = Int(Double(white)*255.0)
            return (color, color, color, Int(Double(alpha)*100.0))
        } else {
            return (0, 0, 0, 0)
        }
    }
    
    public var hex6:String {
        let (r,g,b,_) = RGBA
        return String(format: "%02X%02X%02X", r, g, b)
    }
    
    public var hex8:String {
        let (r,g,b,a) = RGBA
        return String(format: "%02X%02X%02X%02X", r, g, b, a)
    }
    
    public var HSBA:(Int, Int, Int, Int) {
        var h:CGFloat = 0, s:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        if getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            return (Int(Double(h)*360.0), Int(Double(s)*100.0), Int(Double(b)*100.0), Int(Double(a)*100.0))
        } else {
            return (0, 0, 0, 0)
        }
    }
    
    public func combined(color:UIColor) -> UIColor {
        let (r,g,b, a) = self.RGBA
        let (r1,g1,b1, a1) = color.RGBA
        return UIColor(RGBA:((r + r1)/2).limited(0, 255),
                       ((g + g1)/2).limited(0, 255),
                       ((b + b1)/2).limited(0, 255),
                       ((a + a1)/2).limited(0, 255))
    }
    
    public func divided(color:UIColor) -> UIColor {
        let (r,g,b,a) = self.RGBA
        let (r1,g1,b1,a1) = color.RGBA
        return UIColor(RGBA:(2*r - r1).limited(0, 255),
                       (2*g - g1).limited(0, 255),
                       (2*b - b1).limited(0, 255),
                       (2*a - a1).limited(0, 255))
    }
    
    public func lighted(level:Int) -> UIColor {
        let (h, s, b, a) = HSBA
        let nb = (b+level).limited(0, 100)
        return UIColor(HSBA:h, s, nb, a)
    }
    
    public func darked(level:Int) -> UIColor {
        return lighted(level: 0 - level)
    }
}
