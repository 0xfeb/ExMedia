//
//  ColorVC.swift
//  ExMediaDemo
//
//  Created by 王渊鸥 on 2019/3/1.
//  Copyright © 2019 王渊鸥. All rights reserved.
//

import UIKit
import ExMedia
import ExType

class ColorVC: UIViewController {
    @IBOutlet weak var aColorInput: UITextField!
    @IBOutlet weak var aColorDisplay: UIView!
    @IBOutlet weak var aColorHex6: UILabel!
    @IBOutlet weak var aColorHex8: UILabel!
    @IBOutlet weak var aColorHSBA: UILabel!
    
    @IBOutlet weak var anotherColorInput: UITextField!
    @IBOutlet weak var anotherColorDisplay: UIView!
    
    @IBOutlet weak var operateLevel: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var setsCount: UITextField!
    @IBOutlet weak var setsDistance: UITextField!
    
    @IBOutlet weak var colorsSetCollection: UICollectionView!
    
    var colors:[UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let layout = colorsSetCollection
            .frame
            .size
            .buildGrids(itemCountInRow: 5)?
            .gap(border: CGSize(width: 4, height: 5), gap: CGSize(width: 4, height: 5))
            .itemHeight(rate: 1.0, fix: 0)
            .collectionViewLayout {
            colorsSetCollection.collectionViewLayout = layout
        }
    }
    
    private func resign() {
        aColorInput.resignFirstResponder()
        anotherColorInput.resignFirstResponder()
        operateLevel.resignFirstResponder()
        setsCount.resignFirstResponder()
        setsDistance.resignFirstResponder()
    }
    
    @IBAction func onChangeAColor(_ sender: UITextField) {
        if let text = sender.text {
            let color = UIColor(hex: text)
            aColorDisplay.backgroundColor = color
            
            aColorHex6.text = color.hex6
            aColorHex8.text = color.hex8
            let hsba = color.HSBA
            aColorHSBA.text = "\(Int(hsba.0*360)) \(Int(hsba.1*100)) \(Int(hsba.2*100)) \(Int(hsba.3*100))"
        }
    }
    
    @IBAction func onChangeAnotherColor(_ sender: UITextField) {
        if let text = sender.text {
            let color = UIColor(hex: text)
            anotherColorDisplay.backgroundColor = color
        }
    }
    
    @IBAction func onClickCombine(_ sender: Any) {
        resign()
        if let aText = aColorInput.text, let anotherText = anotherColorInput.text {
            let aColor = UIColor(hex: aText)
            let anotherColor = UIColor(hex: anotherText)
            
            let resultColor = aColor.combined(color: anotherColor)
            resultLabel.text = resultColor.hex8
            resultLabel.textColor = resultColor.opsite
            resultLabel.backgroundColor = resultColor
        }
    }
    
    @IBAction func onClickLighter(_ sender: Any) {
        resign()
        if let aText = aColorInput.text, let levelText = operateLevel.text, let level = Int(levelText) {
            let aColor = UIColor(hex: aText)
            
            let resultColor = aColor.lighted(level: level)
            resultLabel.text = resultColor.hex8
            resultLabel.textColor = resultColor.opsite
            resultLabel.backgroundColor = resultColor
        }
    }
    
    @IBAction func onClickDarker(_ sender: Any) {
        resign()
        if let aText = aColorInput.text, let levelText = operateLevel.text, let level = Int(levelText) {
            let aColor = UIColor(hex: aText)
            
            let resultColor = aColor.darked(level: level)
            resultLabel.text = resultColor.hex8
            resultLabel.textColor = resultColor.opsite
            resultLabel.backgroundColor = resultColor
        }
    }
    
    @IBAction func onClickCreate(_ sender: Any) {
        resign()
        if let aText = aColorInput.text, let countText = setsCount.text, let distanceText = setsDistance.text {
            let aColor = UIColor(hex: aText)
            let count = Int(countText) ?? 1
            let distance = Int(distanceText) ?? 10
            colors = aColor.sets(by: count, distance: distance)
            colorsSetCollection.reloadData()
            
            print(colors.map({ $0.hex6 }))
        }
    }
    
    @IBAction func onSaveImage(_ sender: Any) {
        let color = aColorDisplay.backgroundColor!
        let image = color.buildImage()
        
        image.saveToPhotos { [weak self] in
            guard let vc = self else { return }
            
            let alert = UIAlertController(title: "添加授权", message: "存储图片", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            vc.present(alert, animated: true, completion: nil)
        }
    }
}

extension ColorVC : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath)
        let color = colors[indexPath.row]
        cell.backgroundColor = color
        
        return cell
    }
}
