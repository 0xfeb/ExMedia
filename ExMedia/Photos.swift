//
//  Photo.swift
//  coastline
//
//  Created by 王渊鸥 on 2017/8/31.
//  Copyright © 2017年 WangYuanOu. All rights reserved.
//

import Photos

public extension PHAsset {
    public func image(bySize size:CGSize? = nil) -> UIImage? {
        if let size = size {
            let scale = UIScreen.main.scale
            let size = CGSize(width: size.width*scale, height: size.height*scale)
            
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var thumbnail:UIImage?
            option.isSynchronous = true
            option.isNetworkAccessAllowed = true
            option.version = .current
            option.deliveryMode = .fastFormat
            manager.requestImage(for: self, targetSize: size, contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result
            })
            return thumbnail
        } else {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var image:UIImage? = nil
            option.isSynchronous = true
            option.isNetworkAccessAllowed = true
            option.version = .current
            option.deliveryMode = .fastFormat
            manager.requestImageData(for: self, options: option) { (data, _, _, _) in
                if let data = data {
                    image = UIImage(data: data)
                }
            }
            return image
        }
    }
}


public extension PHAssetCollection {
    static let AssetTitles = [
        "Slo-mo":"慢动作",
        "Recently Added":"最近添加",
        "Favorites":"最爱",
        "Recently Deleted":"最近删除",
        "Videos":"视频",
        "All Photos":"所有照片",
        "Selfies":"自拍",
        "Screenshots":"屏幕快照"
    ]
    
    static func localTitle(_ name:String) -> String {
        return PHAssetCollection.AssetTitles[name] ?? name
    }
    
    private static func fetchAlbums(_ skipNames:[String] = ["Slo-mo", "Videos", "Recently Deleted"]) -> [PHAssetCollection] {
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        let sSmartAlbums = (0..<smartAlbums.count).map{ smartAlbums.object(at: $0) }.filter{ !skipNames.contains($0.localizedTitle!) }
        
        let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .smartAlbumUserLibrary, options: nil)
        let sAlbums = (0..<albums.count).map{ albums.object(at: $0) }
        
        return sSmartAlbums + sAlbums
    }
    
    static func fetchAlbum(name:String) -> [PHAssetCollection] {
        let cols = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [name], options: nil)
        return (0..<cols.count).map{
            return cols.object(at: $0)
        }
    }
    
    //获取相册列表
    static func albums(deniedAlert:@escaping ()->Void, skipNames:[String] = ["Slo-mo", "Videos", "Recently Deleted"]) -> [PHAssetCollection] {
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            return fetchAlbums(skipNames)
        } else {
            let sema = DispatchSemaphore(value: 0)
            var result:[PHAssetCollection] = []
            PHPhotoLibrary.requestAuthorization({ (state) in
                if state == PHAuthorizationStatus.authorized {
                    result = fetchAlbums(skipNames)
                } else if state == PHAuthorizationStatus.denied {
                    deniedAlert()
                }
            })
            sema.wait()
            return result
        }
    }
    
    //从相册中获取资源
    func assets(_ ascending:Bool = false) -> [PHAsset] {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: ascending)]
        
        let assets = PHAsset.fetchAssets(in: self, options: options)
        return (0..<assets.count).map{ assets.object(at: $0) }
    }
    
    //获取所有资源
    static func allAssets(deniedAlert:@escaping ()->Void, skipNames:[String] = ["Slo-mo", "Videos", "Recently Deleted"]) -> [PHAsset] {
        let collections = albums(deniedAlert: deniedAlert, skipNames: skipNames)
        var result:[PHAsset] = []
        for col in collections {
            result += col.assets()
        }
        
        return result
    }
}
