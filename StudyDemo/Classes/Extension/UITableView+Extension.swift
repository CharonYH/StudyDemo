//
//  UITableView+Extension.swift
//  StudyDemo
//
//  Created by Charron on 2021/10/28.
//

import UIKit
 
extension UITableView {
    struct CellConfig<Cell,Item> where Cell: UITableViewCell {
        
        typealias Config = (Cell,Item) -> Void
        init(config: @escaping UITableView.CellConfig<Cell,Item>.Config) {
            
        }
    }
}
