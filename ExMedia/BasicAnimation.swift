//
//  basicAnimation.swift
//  ExAnimation
//
//  Created by 王渊鸥 on 2018/10/7.
//  Copyright © 2018年 王渊鸥. All rights reserved.
//

import Foundation
import UIKit



public extension CABasicAnimation {
    public enum Mode {
        //layer
        //下列layer必须使用"transform"作为key
        case rotateX(from:CGFloat, to:CGFloat) //上下翻转
        case rotateY(from:CGFloat, to:CGFloat) //左右翻转
        case rotateZ(from:CGFloat, to:CGFloat) //平面翻转, 顺时针
        case scale(fromX:CGFloat, fromY:CGFloat, fromZ:CGFloat, toX:CGFloat, toY:CGFloat, toZ:CGFloat)
        case scaleX(from:CGFloat, to:CGFloat)
        case scaleY(from:CGFloat, to:CGFloat)
        case scaleZ(from:CGFloat, to:CGFloat)
        case translate(fromX:CGFloat, fromY:CGFloat, fromZ:CGFloat, toX:CGFloat, toY:CGFloat, toZ:CGFloat)
        case translateX(from:CGFloat, to:CGFloat)
        case translateY(from:CGFloat, to:CGFloat)
        case translateZ(from:CGFloat, to:CGFloat)
        
        case contents(from:CGImage?, to:CGImage?)   //key为nil
        case contentsRect(from:CGRect, to:CGRect)   //key为nil, rect使用的是0~1.0之间的相对值
        case contentsCenter(from:CGRect, to:CGRect) //key为nil, rect使用的是0~1.0之间的相对值
        case opacity(from:CGFloat, to:CGFloat)  //透明度, 值为0~0.1
        //case masksToBounds(from:Bool, to:Bool)
        //case isDoubleSided(from:Bool, to:Bool)  //是否绘制layer的背面
        case cornerRadius(from:CGFloat, to:CGFloat)
        case borderWidth(from:CGFloat, to:CGFloat)
        case borderColor(from:CGColor, to:CGColor)
        case shadowOpacity(from:CGFloat, to:CGFloat)    //阴影透明度
        case shadowOffset(from:CGSize, to:CGSize)
        case shadowColor(from:CGColor?, to:CGColor?)
        case shadowPath(from:CGPath?, to:CGPath?)
        
        case filters(from:[Any]?, to:[Any]?)
        case compositingFilter(from:Any?, to:Any?)
        case backgroundFileters(from:[Any]?, to:[Any]?)
        
        case bounds(from:CGRect, to:CGRect)
        case boundsOrigin(from:CGPoint, to:CGPoint)
        case boundsSize(from:CGSize, to:CGSize)
        case boundsOriginX(from:CGFloat, to:CGFloat)
        case boundsOriginY(from:CGFloat, to:CGFloat)
        case boundsSizeWidth(from:CGFloat, to:CGFloat)
        case boundsSizeHeight(from:CGFloat, to:CGFloat)
        
        case position(fromX:CGFloat, fromY:CGFloat, toX:CGFloat, toY:CGFloat)
        case positionX(from:CGFloat, to:CGFloat)
        case positionY(from:CGFloat, to:CGFloat)
        
        case zPosition(from:CGFloat, to:CGFloat)
        
        case anchorPointZ(from:CGFloat, to:CGFloat)
        case anchorPoint(from:CGPoint, to:CGPoint)
        case anchorPointX(from:CGFloat, to:CGFloat)
        case anchorPointY(from:CGFloat, to:CGFloat)
        
        case transform(from:CATransform3D, to:CATransform3D)
        case sublayerTransform(from:CATransform3D, to:CATransform3D)
        
        
        //text layer
        case fontSize(from:CGFloat, to:CGFloat)
        case foregroundColor(from:CGColor?, to:CGColor?)
        
        
        //shape layer
        case path(from:CGPath?, to:CGPath?)
        case fillColor(from:CGColor?, to:CGColor?)
        case lineDashPhase(from:CGFloat, to:CGFloat)
        case lineWidth(from:CGFloat, to:CGFloat)
        case miterLimit(from:CGFloat, to:CGFloat)
        case strokeColor(from:CGColor?, to:CGColor?)
        case strokeStart(from:CGFloat, to:CGFloat)
        case strokeEnd(from:CGFloat, to:CGFloat)
        
        //gradient layer
        case colors(from:[CGColor]?, to:[CGColor]?)
        case locations(from:[CGFloat]?, to:[CGFloat]?)
        case startPoint(from:CGPoint, to:CGPoint)
        case endPoint(from:CGPoint, to:CGPoint)
        
        //emitter layer
        case emitterPosition(from:CGPoint, to:CGPoint)
        case emitterZPosition(from:CGFloat, to:CGFloat)
        case emitterSize(from:CGSize, to:CGSize)
        
        //replicator layer
        case instanceDelay(from:TimeInterval, to:TimeInterval)
        case instanceTransform(from:CATransform3D, to:CATransform3D)
        case instanceColor(from:CGColor?, to:CGColor?)
        case instanceRedOffset(from:Float, to:Float)
        case instanceGreenOffset(from:Float, to:Float)
        case instanceBlueOffset(from:Float, to:Float)
        case instanceAlphaOffset(from:Float, to:Float)
    }
    
    public convenience init(mode:Mode) {
        switch mode {
        case .rotateX(from: let from, to: let to):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.rotateX)
            self.fromValue = from
            self.toValue = to
        case .rotateY(let from, let to):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.rotateY)
            self.fromValue = from
            self.toValue = to
        case .rotateZ(let from, let to):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.rotateZ)
            self.fromValue = from
            self.toValue = to
        case .scale(let fromX, let fromY, let fromZ, let toX, let toY, let toZ):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.scale)
            self.fromValue = [fromX, fromY, fromZ]
            self.toValue = [toX, toY, toZ]
        case .scaleX(let from, let to):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.scaleX)
            self.fromValue = from
            self.toValue = to
        case .scaleY(let from, let to):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.scaleY)
            self.fromValue = from
            self.toValue = to
        case .scaleZ(let from, let to):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.scaleZ)
            self.fromValue = from
            self.toValue = to
        case .translate(let fromX, let fromY, let fromZ, let toX, let toY, let toZ):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.translate)
            self.fromValue = [fromX, fromY, fromZ]
            self.toValue = [toX, toY, toZ]
        case .translateX(let from, let to):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.translateX)
            self.fromValue = from
            self.toValue = to
        case .translateY(let from, let to):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.translateY)
            self.fromValue = from
            self.toValue = to
        case .translateZ(let from, let to):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.translateZ)
            self.fromValue = from
            self.toValue = to
        case .contents(let from, let to):
            self.init(keyPath: "contents")
            self.fromValue = from
            self.toValue = to
        case .contentsRect(let from, let to):
            self.init(keyPath: "contentsRect")
            self.fromValue = from
            self.toValue = to
        case .contentsCenter(let from, let to):
            self.init(keyPath: "contentsCenter")
            self.fromValue = from
            self.toValue = to
        case .opacity(let from, let to):
            self.init(keyPath: "opacity")
            self.fromValue = from
            self.toValue = to
//        case .masksToBounds(let from, let to):
//            self.init(keyPath: "masksToBounds")
//            self.fromValue = from
//            self.toValue = to
//        case .isDoubleSided(let from, let to):
//            self.init(keyPath: "isDoubleSided")
//            self.fromValue = from
//            self.toValue = to
        case .cornerRadius(let from, let to):
            self.init(keyPath: "cornerRadius")
            self.fromValue = from
            self.toValue = to
        case .borderWidth(let from, let to):
            self.init(keyPath: "borderWidth")
            self.fromValue = from
            self.toValue = to
        case .borderColor(let from, let to):
            self.init(keyPath: "borderColor")
            self.fromValue = from
            self.toValue = to
        case .shadowOpacity(let from, let to):
            self.init(keyPath: "shadowOpacity")
            self.fromValue = from
            self.toValue = to
        case .shadowOffset(let from, let to):
            self.init(keyPath: "shadowOffset")
            self.fromValue = from
            self.toValue = to
        case .shadowColor(let from, let to):
            self.init(keyPath: "shadowColor")
            self.fromValue = from
            self.toValue = to
        case .shadowPath(let from, let to):
            self.init(keyPath: "shadowPath")
            self.fromValue = from
            self.toValue = to
        case .filters(let from, let to):
            self.init(keyPath: "filters")
            self.fromValue = from
            self.toValue = to
        case .compositingFilter(let from, let to):
            self.init(keyPath: "compositingFilter")
            self.fromValue = from
            self.toValue = to
        case .backgroundFileters(let from, let to):
            self.init(keyPath: "backgroundFileters")
            self.fromValue = from
            self.toValue = to
        case .bounds(let from, let to):
            self.init(keyPath: "bounds")
            self.fromValue = from
            self.toValue = to
        case .boundsOrigin(let from, let to):
            self.init(keyPath: "bounds.origin")
            self.fromValue = from
            self.toValue = to
        case .boundsSize(let from, let to):
            self.init(keyPath: "bounds.size")
            self.fromValue = from
            self.toValue = to
        case .boundsOriginX(let from, let to):
            self.init(keyPath: "bounds.origin.x")
            self.fromValue = from
            self.toValue = to
        case .boundsOriginY(let from, let to):
            self.init(keyPath: "bounds.origin.y")
            self.fromValue = from
            self.toValue = to
        case .boundsSizeWidth(let from, let to):
            self.init(keyPath: "bounds.size.width")
            self.fromValue = from
            self.toValue = to
        case .boundsSizeHeight(let from, let to):
            self.init(keyPath: "bounds.size.height")
            self.fromValue = from
            self.toValue = to
        case .position(let fromX, let fromY, let toX, let toY):
            self.init(keyPath: "position")
            self.fromValue = [fromX, fromY]
            self.toValue = [toX, toY]
        case .positionX(let from, let to):
            self.init(keyPath: "position.x")
            self.fromValue = from
            self.toValue = to
        case .positionY(let from, let to):
            self.init(keyPath: "position.y")
            self.fromValue = from
            self.toValue = to
        case .zPosition(let from, let to):
            self.init(keyPath: "zPosition")
            self.fromValue = from
            self.toValue = to
        case .anchorPointZ(let from, let to):
            self.init(keyPath: "anchorPointZ")
            self.fromValue = from
            self.toValue = to
        case .anchorPoint(let from, let to):
            self.init(keyPath: "anchorPoint")
            self.fromValue = from
            self.toValue = to
        case .anchorPointX(let from, let to):
            self.init(keyPath: "anchorPoint.x")
            self.fromValue = from
            self.toValue = to
        case .anchorPointY(let from, let to):
            self.init(keyPath: "anchorPoint.y")
            self.fromValue = from
            self.toValue = to
        case .transform(let from, let to):
            self.init(keyPath: "transform")
            self.fromValue = from
            self.toValue = to
        case .sublayerTransform(let from, let to):
            self.init(keyPath: "sublayerTransform")
            self.fromValue = from
            self.toValue = to
        case .fontSize(let from, let to):
            self.init(keyPath: "fontSize")
            self.fromValue = from
            self.toValue = to
        case .foregroundColor(let from, let to):
            self.init(keyPath: "foregroundColor")
            self.fromValue = from
            self.toValue = to
        case .fillColor(let from, let to):
            self.init(keyPath: "fillColor")
            self.fromValue = from
            self.toValue = to
        case .lineDashPhase(let from, let to):
            self.init(keyPath: "lineDashPhase")
            self.fromValue = from
            self.toValue = to
        case .lineWidth(let from, let to):
            self.init(keyPath: "lineWidth")
            self.fromValue = from
            self.toValue = to
        case .miterLimit(let from, let to):
            self.init(keyPath: "miterLimit")
            self.fromValue = from
            self.toValue = to
        case .strokeColor(let from, let to):
            self.init(keyPath: "strokeColor")
            self.fromValue = from
            self.toValue = to
        case .strokeStart(let from, let to):
            self.init(keyPath: "strokeStart")
            self.fromValue = from
            self.toValue = to
        case .strokeEnd(let from, let to):
            self.init(keyPath: "strokeEnd")
            self.fromValue = from
            self.toValue = to
        case .colors(let from, let to):
            self.init(keyPath: "colors")
            self.fromValue = from
            self.toValue = to
        case .locations(let from, let to):
            self.init(keyPath: "locations")
            self.fromValue = from
            self.toValue = to
        case .startPoint(let from, let to):
            self.init(keyPath: "startPoint")
            self.fromValue = from
            self.toValue = to
        case .endPoint(let from, let to):
            self.init(keyPath: "endPoint")
            self.fromValue = from
            self.toValue = to
        case .emitterPosition(let from, let to):
            self.init(keyPath: "emitterPosition")
            self.fromValue = from
            self.toValue = to
        case .emitterZPosition(let from, let to):
            self.init(keyPath: "emitterZPosition")
            self.fromValue = from
            self.toValue = to
        case .emitterSize(let from, let to):
            self.init(keyPath: "emitterSize")
            self.fromValue = from
            self.toValue = to
        case .instanceDelay(let from, let to):
            self.init(keyPath: "instanceDelay")
            self.fromValue = from
            self.toValue = to
        case .instanceTransform(let from, let to):
            self.init(keyPath: "instanceTransform")
            self.fromValue = from
            self.toValue = to
        case .instanceColor(let from, let to):
            self.init(keyPath: "instanceColor")
            self.fromValue = from
            self.toValue = to
        case .instanceRedOffset(let from, let to):
            self.init(keyPath: "instanceRedOffset")
            self.fromValue = from
            self.toValue = to
        case .instanceGreenOffset(let from, let to):
            self.init(keyPath: "instanceGreenOffset")
            self.fromValue = from
            self.toValue = to
        case .instanceBlueOffset(let from, let to):
            self.init(keyPath: "instanceBlueOffset")
            self.fromValue = from
            self.toValue = to
        case .instanceAlphaOffset(let from, let to):
            self.init(keyPath: "instanceAlphaOffset")
            self.fromValue = from
            self.toValue = to
        case .path(let from, let to):
            self.init(keyPath: "path")
            self.fromValue = from
            self.toValue = to
        }
    }
}
