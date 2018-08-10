//
//  Sound.swift
//  ExMedia
//
//  Created by 王渊鸥 on 2018/7/29.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation
import AudioToolbox

public func ex_vibrate() {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
}

public func ex_registerSound(resFile:String) -> SystemSoundID {
    let soundResource = URL(fileURLWithPath: resFile)
    var soundId:SystemSoundID = 0
    AudioServicesCreateSystemSoundID(soundResource as CFURL, &soundId)
    return soundId
}

public func ex_playSound(soundId:SystemSoundID) {
    AudioServicesPlaySystemSound(soundId)
}
