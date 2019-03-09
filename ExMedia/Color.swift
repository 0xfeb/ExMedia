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
        
        let red = Int(hex:colorText[0..<2] ?? "ff")
        let green = Int(hex:colorText[2..<4] ?? "ff")
        let blue = Int(hex:colorText[4..<6] ?? "ff")
        
        if colorText.count > 6 {
            let alpha = Int(hex:colorText[6..<8] ?? "ff" )
            self.init(RGBA: Double(red)/255, Double(green)/255, Double(blue)/255, Double(alpha)/255)
        } else {
            self.init(RGBA: Double(red)/255, Double(green)/255, Double(blue)/255, 1.0)
        }
    }
    
    public convenience init(RGBA r:Double, _ g:Double, _ b:Double, _ a:Double) {
        self.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
    }
    
    public convenience init(HSBA h:Double, _ s:Double, _ b:Double, _ a:Double) {
        self.init(hue: CGFloat(h), saturation: CGFloat(s), brightness: CGFloat(b), alpha: CGFloat(a))
    }
    
    public var RGBA:(Double, Double, Double, Double) {
        var red:CGFloat = 0, green:CGFloat = 0, blue:CGFloat = 0, alpha:CGFloat = 0, white:CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return (Double(red), Double(green), Double(blue), Double(alpha))
        } else if self.getWhite(&white, alpha: &alpha) {
            let color = Double(white)
            return (color, color, color, Double(alpha))
        } else {
            return (0, 0, 0, 0)
        }
    }
    
    public var hex6:String {
        let (r,g,b,_) = RGBA
        return String(format: "%02X%02X%02X", Int(r*255.0), Int(g*255.0), Int(b*255.0))
    }
    
    public var hex8:String {
        let (r,g,b,a) = RGBA
        return String(format: "%02X%02X%02X%02X", Int(r*255.0), Int(g*255.0), Int(b*255.0), Int(a*255.0))
    }
    
    public var HSBA:(Double, Double, Double, Double) {
        var h:CGFloat = 0, s:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        if getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            return (Double(h), Double(s), Double(b), Double(a))
        } else {
            return (0, 0, 0, 0)
        }
    }
    
    public func combined(color:UIColor) -> UIColor {
        let (r,g,b, a) = self.RGBA
        let (r1,g1,b1, a1) = color.RGBA
        return UIColor(RGBA:((r + r1)/2).limited(0, 1),
                       ((g + g1)/2).limited(0, 1),
                       ((b + b1)/2).limited(0, 1),
                       ((a + a1)/2).limited(0, 1))
    }
    
    public func divided(color:UIColor) -> UIColor {
        let (r,g,b,a) = self.RGBA
        let (r1,g1,b1,a1) = color.RGBA
        return UIColor(RGBA:(r - r1).limited(0, 1),
                       (g - g1).limited(0, 1),
                       (b - b1).limited(0, 1),
                       (a - a1).limited(0, 1))
    }
    
    public func lighted(level:Int = 1) -> UIColor {
        let (h, s, b, a) = HSBA
        let nb = (b+0.01*Double(level)).limited(0, 1)
        return UIColor(HSBA:Double(h), Double(s), Double(nb), Double(a))
    }
    
    public func darked(level:Int = 1) -> UIColor {
        return lighted(level: 0 - level)
    }
    
    public var opsite:UIColor {
        let (r,g,b,a) = self.RGBA
        return UIColor(HSBA: 1-r, 1-g, 1-b, a)
    }
    
    public func sets(by count:Int, distance:Int) -> [UIColor] {
        func plus(_ lhs:Double, _ rhs:Double, maxLimit:Double) -> Double {
            var result = lhs + rhs
            while result < 0 {
                result += maxLimit
            }
            
            while result > maxLimit {
                result -= maxLimit
            }
            
            return result
        }
        
        let dist = Double(distance)/360.0
        let (h, s, b, a) = self.HSBA
        
        let nc = count / 2
        var result:[UIColor] = [self]
        
        for p in 1...nc {
            let nh1 = plus(h, Double(p)*dist, maxLimit: 1)
            let nh2 = plus(h, -Double(p)*dist, maxLimit: 1)
            
            result.append(UIColor(HSBA: nh1, s, b, a))
            if result.count == count {
                break
            }
            result.append(UIColor(HSBA: nh2, s, b, a))
        }
        
        return result
    }
}
