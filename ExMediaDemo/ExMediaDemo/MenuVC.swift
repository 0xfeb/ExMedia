//
//  MenuVC.swift
//  ExMediaDemo
//
//  Created by 王渊鸥 on 2019/1/31.
//  Copyright © 2019 王渊鸥. All rights reserved.
//

import UIKit

class MenuVC: UITableViewController {
    let cells = [("Test Image", "TestImageVC"),
                 ("Test Photo", "TestPhotoVC"),
                 ("Test BarScanner", "BarCodeScannerVC"),
                 ("Test Sound", "SoundVC"),
                 ("Test Color", "ColorVC")]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell("menu", style: .default)
        cell.textLabel?.text = cells[indexPath.row].0
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = cells[indexPath.row].1
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: name) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
