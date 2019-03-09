//
//  Sound.swift
//  ExMedia
//
//  Created by 王渊鸥 on 2018/7/29.
//  Copyright © 2018 WangYuanOu. All rights reserved.
//

import Foundation
import AudioToolbox


public class ExSound {
    public static var soundList:[(SystemSoundID, URL)] = []
    var soundId:SystemSoundID
    
    public static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    public static func createSound(_ resFile:String) -> SystemSoundID {
        let soundResource = URL(fileURLWithPath: resFile)
        if let exists = soundList.first(where: { $0.1 == soundResource }) {
            return exists.0
        }
        
        var soundId:SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundResource as CFURL, &soundId)
        
        soundList.append((soundId, soundResource))
        return soundId
    }
    
    public static func clearAll() {
        soundList.forEach({
            AudioServicesDisposeSystemSoundID($0.0)
        })
        
        soundList.removeAll()
    }
    
    public init(_ resFile:String) {
        soundId = ExSound.createSound(resFile)
    }
    
    public func play() {
        AudioServicesPlaySystemSound(soundId)
    }
}
