//
//  SoundVC.swift
//  ExMediaDemo
//
//  Created by 王渊鸥 on 2019/2/27.
//  Copyright © 2019 王渊鸥. All rights reserved.
//

import UIKit
import ExMedia
import ExType

class SoundVC: UIViewController {
    var sound:ExSound!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sound = ExSound(String.bundlePath.appendPath("1.wav"))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onClickPlay(_ sender: Any) {
        sound.play()
    }
    
    @IBAction func onClickViber(_ sender: Any) {
        ExSound.vibrate()
    }
}
