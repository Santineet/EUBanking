//
//  UITableViewHeaderFooterView+Convinience.swift
//  Magnet
//
//  Created by Mairambek on 2/14/21.
//

import UIKit

extension TableIdentifiable where Self: UITableViewHeaderFooterView {
    
    static var reuseId: String {
        return String(describing: self)
    }
}

extension NibLoadable where Self: UITableViewHeaderFooterView {
    
    static var nibName: String {
        return String(describing: self)
    }
}
