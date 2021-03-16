//
//  UICollectionReusableView+Convenience.swift
//  Magnet
//
//  Created by Mairambek on 2/14/21.
//

import UIKit

protocol CollectionIdentifiable: UICollectionReusableView {
    static var reuseId: String { get }
}

extension CollectionIdentifiable where Self: UICollectionReusableView {
    
    static var reuseId: String {
        return String(describing: self)
    }
}

protocol NibLoadable: UIView {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension NibLoadable where Self: CollectionIdentifiable {
    
    static var nibName: String {
        return String(describing: self)
    }
}

extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: self.nibName, bundle: .main)
    }
    
    static func loadFromNib(_ bundle: Bundle = .main, owner: Any? = nil, options: [UINib.OptionsKey: Any]? = nil) -> Self {
        
        return (bundle.loadNibNamed(nibName, owner: owner, options: options)!.first as? Self)!
    }
}
