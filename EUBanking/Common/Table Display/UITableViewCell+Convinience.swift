//
//  UITableViewCell+Convinience.swift
//  Magnet
//
//  Created by Mairambek on 2/14/21.
//

import UIKit

protocol TableIdentifiable {
    static var reuseId: String { get }
}

extension TableIdentifiable where Self: UITableViewCell {
    
    static var reuseId: String {
        return String(describing: self)
    }
}

extension NibLoadable where Self: UITableViewCell {
    
    static var nibName: String {
        return String(describing: self)
    }
}

class PlainTableViewCell: UITableViewCell, TableIdentifiable {}
