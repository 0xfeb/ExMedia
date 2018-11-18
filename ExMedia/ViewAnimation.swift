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
        
        item.ex_all(compute: { $0.duration }) { (val) in
            let ani = UIViewPropertyAnimator(duration: val.item.duration,
                                             curve: UIView.AnimationCurve.linear,
                                             animations: val.item.action)
            ani.startAnimation(afterDelay: val.used)
            
            list.append(ani)
        }
        
        return list
    }
}
