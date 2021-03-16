//
//  UITableView+Convinience.swift
//  Magnet
//
//  Created by Mairambek on 2/14/21.
//

import UIKit

typealias TableIdentifiableCell = UITableViewCell & TableIdentifiable
typealias NibLoadableTableIdentifiable = NibLoadable & TableIdentifiable
typealias NibLoadableIdentifiableTableCell = UITableViewCell & NibLoadable & TableIdentifiable

typealias IdentifiableTableHeaderFooterView = UITableViewHeaderFooterView & TableIdentifiable
typealias NibLoadableTableHeaderFooterView = UITableViewHeaderFooterView & NibLoadable & TableIdentifiable

extension UITableView {
    
    func dequeueIdentifiableCell<Cell: TableIdentifiableCell>(_ type: Cell.Type, for indexPath: IndexPath) -> Cell {
        
        let reuseId = Cell.reuseId
        
        guard let cell = dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as? Cell else { fatalError() }
        
        return cell
    }
    
    func dequeueIdentifiableHeaderFooter<View: IdentifiableTableHeaderFooterView>(_ type: View.Type) -> View {
        
        let reuseId = View.reuseId
        
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: reuseId) as? View else { fatalError() }
        
        return view
    }
    
    func registerIdentifiableCell<Cell: TableIdentifiableCell>(_ type: Cell.Type) {
        
        register(type, forCellReuseIdentifier: type.reuseId)
    }

    func registerIdentifiableHeaderFooter<View: IdentifiableTableHeaderFooterView>(_ type: View.Type) {
        
        register(type, forHeaderFooterViewReuseIdentifier: type.reuseId)
    }

    func registerNibLoadableCell<Cell: NibLoadableIdentifiableTableCell>(_ type: Cell.Type) {

        register(type.nib, forCellReuseIdentifier: type.reuseId)
    }

    func registerNibLoadableHeaderFooter<View: NibLoadableTableHeaderFooterView>(_ type: View.Type) {

        register(type.nib, forHeaderFooterViewReuseIdentifier: type.reuseId)
    }
}
