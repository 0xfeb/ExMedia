
//
//  BarCodeScanner.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit
import AVFoundation
import ExType

enum ExBarcodeError : Error {
    case canNotSetupDevice
    case canNotAddInput
    case canNotAddOutput
    case canNotSupportMetaType
}

public extension AVCaptureSession {
    func bind(superLayer:CALayer, window:CGSize? = nil) {
        func addMaskLayer(layer:CALayer, frame:CGRect) {
            _ = setup(CALayer()) {
                $0.isOpaque = true
                $0.opacity = 0.5
                $0.backgroundColor = UIColor.white.cgColor
                $0.frame = frame
                superLayer.addSublayer($0)
            }
        }
        
        let layer = AVCaptureVideoPreviewLayer(session: self)
        layer.videoGravity = .resizeAspectFill
        layer.frame = superLayer.bounds
        superLayer.addSublayer(layer)
        
        if let window = window {
            let center = CGRect(center: superLayer.bounds.center, size: window)

            let topGridFrame = CGRect(x: 0, y: 0, width: superLayer.bounds.width, height: center.minY)
            let leftGridFrame = CGRect(x: 0, y: center.minY, width: center.minX, height: center.height)
            let rightGridFrame = CGRect(x: center.maxX, y: center.minY, width: center.minX, height: center.height)
            let bottomGridFrame = CGRect(x: 0, y: center.maxY, width: superLayer.bounds.width, height: center.minY)

            addMaskLayer(layer: superLayer, frame: topGridFrame)
            addMaskLayer(layer: superLayer, frame: leftGridFrame)
            addMaskLayer(layer: superLayer, frame: rightGridFrame)
            addMaskLayer(layer: superLayer, frame: bottomGridFrame)
        }
    }
    
    func bind(device:AVCaptureDevice) throws {
        let input = try AVCaptureDeviceInput(device: device)
        if self.canAddInput(input) {
            self.addInput(input)
        } else {
            throw ExBarcodeError.canNotAddInput
        }
    }
    
    func bind<Object:AVCaptureMetadataOutputObjectsDelegate>(metaList:[AVMetadataObject.ObjectType], delegate:Object, limitInCenter:Bool = true) throws {
        let output = AVCaptureMetadataOutput()
        if limitInCenter {
            output.rectOfInterest = CGRect(x: 0.25, y: 0.25, width: 0.5, height: 0.5)
        }
        if self.canAddOutput(output) {
            self.addOutput(output)
            
            if let conn = output.connection(with: .metadataObject), conn.isVideoOrientationSupported {
                conn.videoOrientation = AVCaptureVideoOrientation(rawValue: UIApplication.shared.statusBarOrientation.rawValue)!
            }
            
            output.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
            try metaList.forEach({
                if !output.availableMetadataObjectTypes.contains($0) {
                    throw ExBarcodeError.canNotSupportMetaType
                }
            })
            
            output.metadataObjectTypes = metaList
        } else {
            throw ExBarcodeError.canNotAddOutput
        }
    }
    
    static func authorize() -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        if status == .authorized {
            return true
        } else {
            let sema = DispatchSemaphore(value: 0)
            var canAuth = false
            AVCaptureDevice.requestAccess(for: .video) { (result) in
                canAuth = result
                sema.signal()
            }
            sema.wait()
            return canAuth
        }
    }
}
