//
//  tableView.swift
//  ExMediaDemo
//
//  Created by 王渊鸥 on 2019/2/4.
//  Copyright © 2019 王渊鸥. All rights reserved.
//

import UIKit

public extension UITableView {
    func cell(_ identifier:String, style:UITableViewCell.CellStyle) -> UITableViewCell {
        if let c = self.dequeueReusableCell(withIdentifier: identifier) {
            return c
        }
        
        return UITableViewCell(style: style, reuseIdentifier: identifier)
    }
}
