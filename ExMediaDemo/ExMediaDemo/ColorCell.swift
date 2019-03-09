//
//  ColorCell.swift
//  ExMediaDemo
//
//  Created by 王渊鸥 on 2019/3/2.
//  Copyright © 2019 王渊鸥. All rights reserved.
//

import UIKit

class ColorCell: UICollectionViewCell {
    var maskLayer:CALayer?
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        if maskLayer == nil {
            let maskLayer = CALayer(layer: layer)
            maskLayer.frame = layer.bounds
            maskLayer.opacity = 0.16
            maskLayer.backgroundColor = UIColor.white.cgColor
            
            let shape = CAShapeLayer()
            
            let path = UIBezierPath()
            path.move(to: maskLayer.bounds.leftTop)
            path.addLine(to: maskLayer.bounds.rightTop)
            path.addLine(to: CGPoint(x: maskLayer.bounds.right, y: maskLayer.bounds.bottom / 4.0))
            path.addLine(to: CGPoint(x: 0, y: 3.0 * maskLayer.bounds.bottom / 4.0))
            path.close()
            shape.path = path.cgPath
            shape.fillColor = UIColor.black.cgColor
            
            maskLayer.mask = shape
            layer.addSublayer(maskLayer)
            
            self.maskLayer = maskLayer
        }
    }
}
