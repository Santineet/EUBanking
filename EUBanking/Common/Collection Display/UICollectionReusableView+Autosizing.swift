//
//  UICollectionReusableView+Autosizing.swift
//  Magnet
//
//  Created by Mairambek on 2/24/21.
//

import UIKit

protocol Autosizing: UICollectionReusableView {
    associatedtype ContentType
    
    static func shared() -> Self
    static func sizeWithContent(_ c: ContentType, targetSize: CGSize) -> CGSize
    func displayContext(_ c: ContentType)
}

extension Autosizing where Self: NibLoadable {
    
    static func sizeWithContent(_ c: ContentType, targetSize: CGSize) -> CGSize {
        let instance = shared()
        instance.displayContext(c)
        return instance.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
}
