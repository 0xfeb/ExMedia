//
//  ViewController.swift
//  ExMediaDemo
//
//  Created by 王渊鸥 on 2019/1/31.
//  Copyright © 2019 王渊鸥. All rights reserved.
//

import UIKit
import ExMedia

class TestImageVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageView.image?.saveToPhotos(deniedAlert: {
            print("image saved denied")
        })
    }


}

