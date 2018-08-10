
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

//TODO: 在手机上检测barcode
public class ExBarcodeManager: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    public var session:AVCaptureSession?
    public var device:AVCaptureDevice?
    public var input:AVCaptureDeviceInput?
    public var layer:AVCaptureVideoPreviewLayer?
    public var output:AVCaptureMetadataOutput?
    
    let orientationSet:[UIInterfaceOrientation:AVCaptureVideoOrientation] = [
        UIInterfaceOrientation.portrait : AVCaptureVideoOrientation.portrait,
        UIInterfaceOrientation.portraitUpsideDown : AVCaptureVideoOrientation.portraitUpsideDown,
        UIInterfaceOrientation.landscapeLeft : AVCaptureVideoOrientation.landscapeLeft,
        UIInterfaceOrientation.landscapeRight : AVCaptureVideoOrientation.landscapeRight,
        ]
    
    var fetchCodeAction:(AVMetadataMachineReadableCodeObject) -> () = { _ in }
    
    public override init() {
        let _session = ex_set(AVCaptureSession()) { (obj) in
            obj.sessionPreset = AVCaptureSession.Preset.high
        }
        session = _session
        
        guard let _device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        device = _device
        
        guard let _input = (try? AVCaptureDeviceInput(device: _device)) else { return }
        input = _input
        if _session.canAddInput(_input) {
            print("--- add input")
            _session.addInput(_input)
        }
        
        output = AVCaptureMetadataOutput()
        if _session.canAddOutput(output!) {
            print("--- add output")
            _session.addOutput(output!)
        }
        
        layer = AVCaptureVideoPreviewLayer(session: _session)
        layer?.videoGravity = .resizeAspectFill
        
        let systemMetaType = output!.availableMetadataObjectTypes
        let supportMetaType:[AVMetadataObject.ObjectType] = [.ean8, .ean13, .code128, .qr, .upce, .code39, .code93, .code39Mod43, .aztec]
        
        output!.metadataObjectTypes = systemMetaType.filter{ supportMetaType.contains($0) }
    }
    
    func setupOrientation() {
        if let connection = output?.connection(with: .metadataObject), connection.isVideoOrientationSupported == true {
            connection.videoOrientation = orientationSet[UIApplication.shared.statusBarOrientation]!
        }
    }
    
    public convenience init(view:UIView, response:@escaping (AVMetadataMachineReadableCodeObject) -> ()) {
        self.init()
        
        bindLayer(view)
        setCodeReceivedAction(response)
        start()
    }
    
    deinit {
        stop()
        if let input = input {
            session?.removeInput(input)
        }
        if let output = output {
            session?.removeOutput(output)
        }
        
        layer?.removeFromSuperlayer()
    }
    
    public func bindLayer(_ view:UIView) {
        guard let layer = layer else { return }
        
        layer.frame = view.bounds
        layer.masksToBounds = true
        layer.cornerRadius = 5.0
        view.layer.addSublayer(layer)
    }   
    
    public func setCodeReceivedAction(_ response:@escaping (AVMetadataMachineReadableCodeObject) -> ()) {
        fetchCodeAction = response
        output?.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    }
    
    public func start() {
        session?.startRunning()
        
        setupOrientation()
    }
    
    public func stop() {
        session?.stopRunning()
    }
    
    public func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let obj = metadataObjects.filter({ $0 is AVMetadataMachineReadableCodeObject }).first {
            if let code = layer?.transformedMetadataObject(for: obj) as? AVMetadataMachineReadableCodeObject {
                fetchCodeAction(code)
                
                stop()
            }
        }
    }
}

public class ExBarcodeScannerView : UIView {
    private var manager : ExBarcodeManager = ExBarcodeManager()
    public var onGetCode:(String?) -> () = { _ in }
    
    public func start() {
        manager.bindLayer(self)
        manager.setCodeReceivedAction { [weak self] (object) in
            self?.manager.stop()
            self?.onGetCode(object.stringValue)
        }
        manager.start()
    }
}
