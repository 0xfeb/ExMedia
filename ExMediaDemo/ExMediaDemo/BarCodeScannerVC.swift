//
//  BarCodeScannerVC.swift
//  ExMediaDemo
//
//  Created by 王渊鸥 on 2019/2/18.
//  Copyright © 2019 王渊鸥. All rights reserved.
//

import UIKit
import AVKit
import ExMedia

class BarCodeScannerVC: UIViewController {
    var captureSession:AVCaptureSession!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !AVCaptureSession.authorize() {
            print("can not auth")
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        guard let device = AVCaptureDevice.default(for: .video) else {
            print("can not use device")
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        let width = view.bounds.width / 2.0
        captureSession.bind(superLayer: view.layer, window:CGSize(width: width, height: width))
        try! captureSession.bind(device: device)
        try! captureSession.bind(metaList: [.qr], delegate: self, limitInCenter: true)
        captureSession.startRunning()
        
        self.view.bringSubviewToFront(resultLabel)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captureSession.stopRunning()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BarCodeScannerVC : AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let item = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            captureSession.stopRunning()
            
            let result = item.stringValue ?? "[none]"
            
            resultLabel.text = result
        }
    }
}
