//
//  ViewAnimation.swift
//  ExMedia
//
//  Created by 王渊鸥 on 2018/11/17.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import UIKit

public extension UIViewPropertyAnimator {
    public static func chain(_ item:(duration:TimeInterval, action:()->()) ...) -> [UIViewPropertyAnimator] {
        var list:[UIViewPropertyAnimator] = []
        
        var used:TimeInterval = 0
        item.forEach { (item) in
            let ani = UIViewPropertyAnimator(duration: item.duration,
                                             curve: UIView.AnimationCurve.linear,
                                             animations: item.action)
            
            ani.startAnimation(afterDelay: used)
            used += item.duration
            
            list.append(ani)
        }
        
        return list
    }
}
