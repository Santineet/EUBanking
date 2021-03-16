//
//  UICollectionView+Convinience.swift
//  Magnet
//
//  Created by Mairambek on 2/14/21.
//

import UIKit

typealias CollectionIdentifiableCell = UICollectionViewCell & CollectionIdentifiable
typealias NibLoadableCollectionIdentifiable = NibLoadable & CollectionIdentifiable
typealias NibLoadableIdentifiableCollectionCell = UICollectionViewCell & NibLoadable & CollectionIdentifiable

extension UICollectionView {
    
    func dequeueIdentifiableCell<Cell: CollectionIdentifiableCell>(_ type: Cell.Type, for indexPath: IndexPath) -> Cell {
        
        let reuseId = Cell.reuseId
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as? Cell else { fatalError() }
        
        return cell
    }
    
    func dequeueIdentifiableSupplementary<View: CollectionIdentifiable>(_ type: View.Type, ofKind: String, for indexPath: IndexPath) -> View {
        
        let reuseId = View.reuseId
        
        guard let view = dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: reuseId, for: indexPath) as? View else { fatalError() }
        
        return view
    }
    
    func registerIdentifiableCell<Cell: CollectionIdentifiableCell>(_ type: Cell.Type) {
        
        register(type, forCellWithReuseIdentifier: type.reuseId)
    }
    
    func registerIdentifiableSupplementary<View: CollectionIdentifiable>(_ type: View.Type, ofKind: String) {
        
        register(type, forSupplementaryViewOfKind: ofKind, withReuseIdentifier: type.reuseId)
    }
    
    func registerNibLoadableCell<Cell: NibLoadableIdentifiableCollectionCell>(_ type: Cell.Type) {
        
        register(type.nib, forCellWithReuseIdentifier: type.reuseId)
    }
    
    func registerNibLoadableSupplementary<View: NibLoadableCollectionIdentifiable>(_ type: View.Type, ofKind: String) {
        
        register(type.nib, forSupplementaryViewOfKind: ofKind, withReuseIdentifier: type.reuseId)
    }
}
