//
//  keyframeAnimation.swift
//  ExAnimation
//
//  Created by 王渊鸥 on 2018/10/7.
//  Copyright © 2018年 王渊鸥. All rights reserved.
//

import Foundation
import UIKit

public extension CAKeyframeAnimation {
    public enum ValuePoint {
        case rotateX(value:CGFloat)
        case rotateY(value:CGFloat)
        case rotateZ(value:CGFloat)
        case scale(x:CGFloat, y:CGFloat, z:CGFloat)
        case scaleX(value:CGFloat)
        case scaleY(value:CGFloat)
        case scaleZ(value:CGFloat)
        case translate(x:CGFloat, y:CGFloat, z:CGFloat)
        case translateX(value:CGFloat)
        case translateY(value:CGFloat)
        case translateZ(value:CGFloat)
        
        case contents(value:CGImage?)
        case contentsRect(value:CGRect)
        case contentsCenter(value:CGRect)
        case opacity(value:CGFloat)
        //case masksToBounds(value:Bool)
        //case isDoubleSided(value:Bool)
        case cornerRadius(value:CGFloat)
        case borderWidth(value:CGFloat)
        case borderColor(value:CGColor)
        case shadowOpacity(value:CGFloat)
        case shadowOffset(value:CGSize)
        case shadowColor(value:CGColor?)
        case shadowPath(value:CGPath?)
        
        case filters(value:[Any]?)
        case compositingFilter(value:Any?)
        case backgroundFileters(value:[Any]?)
        
        case bounds(value:CGRect)
        case boundsOrigin(value:CGPoint)
        case boundsSize(value:CGSize)
        case boundsOriginX(value:CGFloat)
        case boundsOriginY(value:CGFloat)
        case boundsSizeWidth(value:CGFloat)
        case boundsSizeHeight(value:CGFloat)
        
        case position(x:CGFloat, y:CGFloat)
        case positionX(value:CGFloat)
        case positionY(value:CGFloat)
        
        case zPosition(value:CGFloat)
        
        case anchorPointZ(value:CGFloat)
        case anchorPoint(value:CGPoint)
        case anchorPointX(value:CGFloat)
        case anchorPointY(value:CGFloat)
        
        case transform(value:CATransform3D)
        case sublayerTransform(value:CATransform3D)
        
        //text layer
        case fontSize(value:CGFloat)
        case foregroundColor(value:CGColor?)
        
        
        //shape layer
        case path(value:CGPath?)
        case fillColor(value:CGColor?)
        case lineDashPhase(value:CGFloat)
        case lineWidth(value:CGFloat)
        case miterLimit(value:CGFloat)
        case strokeColor(value:CGColor?)
        case strokeStart(value:CGFloat)
        case strokeEnd(value:CGFloat)
        
        //gradient layer
        case colors(value:[CGColor]?)
        case locations(value:[CGFloat]?)
        case startPoint(value:CGPoint)
        case endPoint(value:CGPoint)
        
        //emitter layer
        case emitterPosition(value:CGPoint)
        case emitterZPosition(value:CGFloat)
        case emitterSize(value:CGSize)
        
        //replicator layer
        case instanceDelay(value:TimeInterval)
        case instanceTransform(value:CATransform3D)
        case instanceColor(value:CGColor?)
        case instanceRedOffset(value:Float)
        case instanceGreenOffset(value:Float)
        case instanceBlueOffset(value:Float)
        case instanceAlphaOffset(value:Float)
    }
    
    public convenience init(pointList:[(time:Float, point:ValuePoint)]) {
        guard let mode = pointList.first?.point else {
            self.init()
            return
        }
        
        switch mode {
        case .rotateX(_):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.rotateX)
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.rotateX(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .rotateY(_):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.rotateY)
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.rotateY(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .rotateZ(_):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.rotateZ)
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.rotateZ(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .scale(_):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.scale)
            let values:[[CGFloat]] =  pointList.compactMap{
                if case let ValuePoint.scale(x, y, z) = $0.point {
                    return [x, y, z]
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .scaleX(_):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.scaleX)
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.scaleX(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .scaleY(_):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.scaleY)
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.scaleY(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .scaleZ(_):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.scaleZ)
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.scaleZ(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .translate(_):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.translate)
            let values:[[CGFloat]] =  pointList.compactMap{
                if case let ValuePoint.translate(x, y, z) = $0.point {
                    return [x, y, z]
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .translateX(_):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.translateX)
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.translateX(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .translateY(_):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.translateY)
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.translateY(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .translateZ(_):
            self.init()
            self.valueFunction = CAValueFunction(name: CAValueFunctionName.translateZ)
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.translateZ(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .contents(_):
            self.init(keyPath: "contents")
            let values:[CGImage?] =  pointList.map{
                if case let ValuePoint.contents(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values as [Any]
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .contentsRect(_):
            self.init(keyPath: "contentsRect")
            let values:[CGRect] =  pointList.compactMap{
                if case let ValuePoint.contentsRect(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values as [Any]
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .contentsCenter(_):
            self.init(keyPath: "contentsCenter")
            let values:[CGRect] =  pointList.compactMap{
                if case let ValuePoint.contentsCenter(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values as [Any]
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .opacity(_):
            self.init(keyPath: "opacity")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.opacity(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
//        case .masksToBounds(_):
//            self.init(keyPath: "masksToBounds")
//            let values:[Bool] =  pointList.compactMap{
//                if case let ValuePoint.masksToBounds(value) = $0.point {
//                    return value
//                }
//                return nil
//            }
//            self.values = values
//            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
//        case .isDoubleSided(_):
//            self.init(keyPath: "isDoubleSided")
//            let values:[Bool] =  pointList.compactMap{
//                if case let ValuePoint.isDoubleSided(value) = $0.point {
//                    return value
//                }
//                return nil
//            }
//            self.values = values
//            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .cornerRadius(_):
            self.init(keyPath: "cornerRadius")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.cornerRadius(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .borderWidth(_):
            self.init(keyPath: "borderWidth")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.borderWidth(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .borderColor(_):
            self.init(keyPath: "borderColor")
            let values:[CGColor] =  pointList.compactMap{
                if case let ValuePoint.borderColor(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .shadowOpacity(_):
            self.init(keyPath: "shadowOpacity")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.shadowOpacity(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .shadowOffset(_):
            self.init(keyPath: "shadowOffset")
            let values:[CGSize] =  pointList.compactMap{
                if case let ValuePoint.shadowOffset(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .shadowColor(_):
            self.init(keyPath: "shadowColor")
            let values:[CGColor] =  pointList.compactMap{
                if case let ValuePoint.shadowColor(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .shadowPath(_):
            self.init(keyPath: "shadowPath")
            let values:[CGPath?] =  pointList.map{
                if case let ValuePoint.shadowPath(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values as [Any]
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .filters(_):
            self.init(keyPath: "filters")
            let values:[[Any]?] =  pointList.map{
                if case let ValuePoint.filters(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values as [Any]
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .compositingFilter(_):
            self.init(keyPath: "compositingFilter")
            let values:[Any?] =  pointList.compactMap{
                if case let ValuePoint.compositingFilter(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values as [Any]
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .backgroundFileters(_):
            self.init(keyPath: "backgroundFileters")
            let values:[[Any]?] =  pointList.map{
                if case let ValuePoint.backgroundFileters(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values as [Any]
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .bounds(_):
            self.init(keyPath: "bounds")
            let values:[CGRect] =  pointList.compactMap{
                if case let ValuePoint.bounds(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .boundsOrigin(_):
            self.init(keyPath: "bounds.origin")
            let values:[CGPoint] =  pointList.compactMap{
                if case let ValuePoint.boundsOrigin(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .boundsSize(_):
            self.init(keyPath: "bounds.size")
            let values:[CGSize] =  pointList.compactMap{
                if case let ValuePoint.boundsSize(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .boundsOriginX(_):
            self.init(keyPath: "bounds.origin.x")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.boundsOriginX(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .boundsOriginY(_):
            self.init(keyPath: "bounds.origin.x")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.boundsOriginY(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .boundsSizeWidth(_):
            self.init(keyPath: "bounds.size.width")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.boundsSizeWidth(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .boundsSizeHeight(_):
            self.init(keyPath: "bounds.size.height")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.boundsSizeHeight(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .position(_):
            self.init(keyPath: "position")
            let values:[[CGFloat]] =  pointList.compactMap{
                if case let ValuePoint.position(x, y) = $0.point {
                    return [x, y]
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .positionX(_):
            self.init(keyPath: "position.x")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.positionX(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .positionY(_):
            self.init(keyPath: "position.y")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.rotateX(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .zPosition(_):
            self.init(keyPath: "zPosition")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.zPosition(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .anchorPointZ(_):
            self.init(keyPath: "anchorPointZ")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.anchorPointZ(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .anchorPoint(_):
            self.init(keyPath: "anchorPoint")
            let values:[CGPoint] =  pointList.compactMap{
                if case let ValuePoint.anchorPoint(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .anchorPointX(_):
            self.init(keyPath: "anchorPoint.x")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.anchorPointX(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .anchorPointY(_):
            self.init(keyPath: "anchorPoint.y")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.anchorPointY(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .transform(_):
            self.init(keyPath: "transform")
            let values:[CATransform3D] =  pointList.compactMap{
                if case let ValuePoint.transform(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .sublayerTransform(_):
            self.init(keyPath: "sublayerTransform")
            let values:[CATransform3D] =  pointList.compactMap{
                if case let ValuePoint.sublayerTransform(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .fontSize(_):
            self.init(keyPath: "fontSize")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.fontSize(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .foregroundColor(_):
            self.init(keyPath: "foregroundColor")
            let values:[CGColor?] =  pointList.map{
                if case let ValuePoint.foregroundColor(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values as [Any]
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .path(_):
            self.init(keyPath: "path")
            let values:[CGPath?] =  pointList.map{
                if case let ValuePoint.path(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values as [Any]
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .fillColor(_):
            self.init(keyPath: "fillColor")
            let values:[CGColor?] =  pointList.map{
                if case let ValuePoint.fillColor(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values as [Any]
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .lineDashPhase(_):
            self.init(keyPath: "lineDashPhase")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.lineDashPhase(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .lineWidth(_):
            self.init(keyPath: "lineWidth")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.lineWidth(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .miterLimit(_):
            self.init(keyPath: "miterLimit")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.miterLimit(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .strokeColor(_):
            self.init(keyPath: "strokeColor")
            let values:[CGColor?] =  pointList.map{
                if case let ValuePoint.strokeColor(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values as [Any]
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .strokeStart(_):
            self.init(keyPath: "strokeStart")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.strokeStart(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .strokeEnd(_):
            self.init(keyPath: "strokeEnd")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.strokeEnd(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .colors(_):
            self.init(keyPath: "colors")
            let values:[[CGColor]?] =  pointList.map{
                if case let ValuePoint.colors(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values as [Any]
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .locations(_):
            self.init(keyPath: "locations")
            let values:[[CGFloat]?] =  pointList.map{
                if case let ValuePoint.locations(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values as [Any]
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .startPoint(_):
            self.init(keyPath: "startPoint")
            let values:[CGPoint] =  pointList.compactMap{
                if case let ValuePoint.startPoint(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .endPoint(_):
            self.init(keyPath: "endPoint")
            let values:[CGPoint] =  pointList.compactMap{
                if case let ValuePoint.endPoint(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .emitterPosition(_):
            self.init(keyPath: "emitterPosition")
            let values:[CGPoint] =  pointList.compactMap{
                if case let ValuePoint.emitterPosition(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .emitterZPosition(_):
            self.init(keyPath: "emitterZPosition")
            let values:[CGFloat] =  pointList.compactMap{
                if case let ValuePoint.emitterZPosition(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .emitterSize(_):
            self.init(keyPath: "emitterSize")
            let values:[CGSize] =  pointList.compactMap{
                if case let ValuePoint.emitterSize(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .instanceDelay(_):
            self.init(keyPath: "instanceDelay")
            let values:[TimeInterval] =  pointList.compactMap{
                if case let ValuePoint.instanceDelay(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .instanceTransform(_):
            self.init(keyPath: "instanceTransform")
            let values:[CATransform3D] =  pointList.compactMap{
                if case let ValuePoint.instanceTransform(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .instanceColor(_):
            self.init(keyPath: "instanceColor")
            let values:[CGColor?] =  pointList.map{
                if case let ValuePoint.instanceColor(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values as [Any]
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .instanceRedOffset(_):
            self.init(keyPath: "instanceRedOffset")
            let values:[Float] =  pointList.compactMap{
                if case let ValuePoint.instanceRedOffset(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .instanceGreenOffset(_):
            self.init(keyPath: "instanceGreenOffset")
            let values:[Float] =  pointList.compactMap{
                if case let ValuePoint.instanceGreenOffset(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .instanceBlueOffset(_):
            self.init(keyPath: "instanceBlueOffset")
            let values:[Float] =  pointList.compactMap{
                if case let ValuePoint.instanceBlueOffset(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        case .instanceAlphaOffset(_):
            self.init(keyPath: "instanceAlphaOffset")
            let values:[Float] =  pointList.compactMap{
                if case let ValuePoint.instanceAlphaOffset(value) = $0.point {
                    return value
                }
                return nil
            }
            self.values = values
            self.keyTimes = pointList.map{ NSNumber(value: $0.time) }
        }
    }
}
