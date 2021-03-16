//
//  TableDisplay.swift
//  Magnet
//
//  Created by Mairambek on 2/14/21.
//

import UIKit

protocol TableSectionType {
    var headerData: Any? { get }
    var footerData: Any? { get }
    
    var itemsCount: Int { get }
    
    var cellType: UITableViewCell.Type { get }
    
    func item(forIndex: Int) -> Any
    
    func getAllItems<T>(as: T.Type) -> [T]?
    
    mutating func set(item: Any, forIndex: Int)
    
    mutating func updateHeaderData(_ newValue: Any)
    mutating func updateFooterData(_ newValue: Any)
    
    func prepareCell(fromTable: UITableView, forIndexPath: IndexPath) -> TableIdentifiableCell
    
    func prepareViewForHeader(fromTable: UITableView, forSection: Int) -> UITableViewHeaderFooterView?
    func prepareViewForFooter(fromTable: UITableView, forSection: Int) -> UITableViewHeaderFooterView?
    
    func headerHeight(forTable: UITableView, forSection: Int) -> CGFloat
    func footerHeight(forTable: UITableView, forSection: Int) -> CGFloat
    
    func updateCells(inTable: UITableView, forSection: Int)
}

protocol TableSectionCell: UITableViewCell, TableIdentifiable {
    associatedtype ItemType
    
    func display(item: ItemType)
}

protocol TableSectionHeader: UITableViewHeaderFooterView, TableIdentifiable {
    associatedtype DataType
    
    func display(data: DataType)
}

protocol TableSectionFooter: UITableViewHeaderFooterView, TableIdentifiable {
    associatedtype DataType
    
    func display(data: DataType)
}

struct TableSection<CellType: TableSectionCell>: TableSectionType {
    
    var headerData: Any? { nil }
    var footerData: Any? { nil }
    
    var itemsCount: Int {
        return items.count
    }
    
    var cellType: UITableViewCell.Type {
        return CellType.self
    }
    
    var items: [CellType.ItemType]
    
    init(items i: [CellType.ItemType], cellType: CellType.Type) {
        items = i
    }
    
    func item(forIndex i: Int) -> Any { items[i] }
    
    func getAllItems<T>(as: T.Type) -> [T]? { return items as? [T] }
    
    mutating func set(item: Any, forIndex i: Int) {
        if let newItem = item as? CellType.ItemType {
            items[i] = newItem
        }
    }
    
    func updateHeaderData(_ newValue: Any) {}
    
    func updateFooterData(_ newValue: Any) {}
    
    func prepareCell(fromTable t: UITableView, forIndexPath i: IndexPath) -> TableIdentifiableCell {
        
        let cell = t.dequeueIdentifiableCell(CellType.self, for: i)
        let item = items[i.item]
        
        cell.display(item: item)
        
        return cell
    }
    
    func prepareViewForHeader(fromTable: UITableView, forSection: Int) -> UITableViewHeaderFooterView? {
        return nil
    }
    
    func prepareViewForFooter(fromTable: UITableView, forSection: Int) -> UITableViewHeaderFooterView? {
        return nil
    }
    
    func headerHeight(forTable: UITableView, forSection: Int) -> CGFloat {
        CGFloat.leastNonzeroMagnitude
    }
    
    func footerHeight(forTable: UITableView, forSection: Int) -> CGFloat {
        CGFloat.leastNonzeroMagnitude
    }
    
    func updateCells(inTable table: UITableView, forSection section: Int) {
        
        for row in 0..<items.count {
            
            let idxPath = IndexPath(row: row, section: section)
            
            if let cell = table.cellForRow(at: idxPath) as? CellType {
                
                cell.display(item: items[row])
            }
        }
    }
}

//struct TableShimmeringSection: TableSectionType {
//    
//    var headerData: Any? { nil }
//    var footerData: Any? { nil }
//    
//    private(set) var itemsCount: Int
//    
//    var cellType: UITableViewCell.Type {
//        return TableShimmerCell.self
//    }
//    
//    init(itemsCount count: Int) {
//        itemsCount = count
//    }
//    
//    func item(forIndex: Int) -> Any { () }
//    
//    func getAllItems<T>(as: T.Type) -> [T]? { nil }
//    
//    func set(item: Any, forIndex: Int) {}
//    func updateHeaderData(_ newValue: Any) {}
//    func updateFooterData(_ newValue: Any) {}
//    
//    func prepareCell(fromTable t: UITableView, forIndexPath i: IndexPath) -> TableIdentifiableCell {
//        t.dequeueIdentifiableCell(TableShimmerCell.self, for: i)
//    }
//    
//    func prepareViewForHeader(fromTable: UITableView, forSection: Int) -> UITableViewHeaderFooterView? {
//        return nil
//    }
//    
//    func prepareViewForFooter(fromTable: UITableView, forSection: Int) -> UITableViewHeaderFooterView? {
//        return nil
//    }
//    
//    func headerHeight(forTable: UITableView, forSection: Int) -> CGFloat {
//        0
//    }
//    
//    func footerHeight(forTable: UITableView, forSection: Int) -> CGFloat {
//        0
//    }
//    
//    func updateCells(inTable: UITableView, forSection: Int) {}
//}

extension TableSectionType {
    
    func asAnySection() -> AnyTableSection {
        return AnyTableSection(section: self)
    }
    
    func withHeader<HeaderType: TableSectionHeader>(headerData d: HeaderType.DataType, headerType: HeaderType.Type) -> TableSectionType {
    
        TableSectionHeaderWrapper(section: self, headerData: d, headerType: HeaderType.self)
    }
    
    func withFooter<FooterType: TableSectionFooter>(footerData d: FooterType.DataType, footerType: FooterType.Type) -> TableSectionType {
    
        TableSectionFooterWrapper(section: self, footerData: d, footerType: FooterType.self)
    }
    
    func makeCollapsible(initiallyCollapsed: Bool = false, showsHeaderWhenCollapsed: Bool = false, showsFooterWhenCollapsed: Bool = false) -> TableSectionType {
        TableCollapsibleSectionWrapper(
            wrappedSection: self,
            isCollapsed: initiallyCollapsed,
            showsHeaderWhenCollapsed: showsHeaderWhenCollapsed,
            showsFooterWhenCollapsed: showsFooterWhenCollapsed
        )
    }
    
    func indexPaths(forSection s: Int) -> [IndexPath] {
        (0..<itemsCount).map { (i) -> IndexPath in
            IndexPath(row: i, section: s)
        }
    }
}

struct TableSectionHeaderWrapper<HeaderType: TableSectionHeader>: TableSectionType {
    
    var wrappedSection: TableSectionType
    var headerDataValue: HeaderType.DataType
    
    var headerData: Any? { headerDataValue }
    
    var footerData: Any? { wrappedSection.footerData }
    
    var cellType: UITableViewCell.Type {
        return wrappedSection.cellType
    }
    
    init(section s: TableSectionType, headerData d: HeaderType.DataType, headerType: HeaderType.Type) {
        wrappedSection = s
        headerDataValue = d
    }
    
    var itemsCount: Int {
        return wrappedSection.itemsCount
    }
    
    func item(forIndex i: Int) -> Any {
        wrappedSection.item(forIndex: i)
    }
    
    func getAllItems<T>(as t: T.Type) -> [T]? {
        wrappedSection.getAllItems(as: t)
    }
    
    mutating func set(item: Any, forIndex i: Int) {
        wrappedSection.set(item: item, forIndex: i)
    }
    
    mutating func updateHeaderData(_ newValue: Any) {
        headerDataValue = (newValue as? HeaderType.DataType)!
    }
    
    mutating func updateFooterData(_ newValue: Any) {
        wrappedSection.updateFooterData(newValue)
    }
    
    func prepareCell(fromTable t: UITableView, forIndexPath i: IndexPath) -> TableIdentifiableCell {
        wrappedSection.prepareCell(fromTable: t, forIndexPath: i)
    }
    
    func prepareViewForHeader(fromTable t: UITableView, forSection s: Int) -> UITableViewHeaderFooterView? {
        
        let header = t.dequeueIdentifiableHeaderFooter(HeaderType.self)
        
        header.display(data: headerDataValue)
        
        return header
    }
    
    func prepareViewForFooter(fromTable t: UITableView, forSection s: Int) -> UITableViewHeaderFooterView? {
        wrappedSection.prepareViewForFooter(fromTable: t, forSection: s)
    }
    
    func headerHeight(forTable: UITableView, forSection: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func footerHeight(forTable t: UITableView, forSection s: Int) -> CGFloat {
        wrappedSection.footerHeight(forTable: t, forSection: s)
    }
    
    func updateCells(inTable: UITableView, forSection: Int) {
        wrappedSection.updateCells(inTable: inTable, forSection: forSection)
    }
}

struct TableSectionFooterWrapper<FooterType: TableSectionFooter>: TableSectionType {
    
    var wrappedSection: TableSectionType
    var footerDataValue: FooterType.DataType
    
    var headerData: Any? { wrappedSection.headerData }
    var footerData: Any? { footerDataValue}
    
    var cellType: UITableViewCell.Type {
        return wrappedSection.cellType
    }
    
    init(section s: TableSectionType, footerData d: FooterType.DataType, footerType: FooterType.Type) {
        wrappedSection = s
        footerDataValue = d
    }
    
    var itemsCount: Int {
        return wrappedSection.itemsCount
    }
    
    func item(forIndex i: Int) -> Any {
        wrappedSection.item(forIndex: i)
    }
    
    func getAllItems<T>(as t: T.Type) -> [T]? {
        wrappedSection.getAllItems(as: t)
    }
    
    mutating func set(item: Any, forIndex i: Int) {
        wrappedSection.set(item: item, forIndex: i)
    }
    mutating func updateHeaderData(_ newValue: Any) {
        wrappedSection.updateHeaderData(newValue)
    }
    
    mutating func updateFooterData(_ newValue: Any) {
        footerDataValue = (newValue as? FooterType.DataType)!
    }
    
    func prepareCell(fromTable t: UITableView, forIndexPath i: IndexPath) -> TableIdentifiableCell {
        wrappedSection.prepareCell(fromTable: t, forIndexPath: i)
    }
    
    func prepareViewForHeader(fromTable t: UITableView, forSection s: Int) -> UITableViewHeaderFooterView? {
        wrappedSection.prepareViewForHeader(fromTable: t, forSection: s)
    }
    
    func prepareViewForFooter(fromTable t: UITableView, forSection s: Int) -> UITableViewHeaderFooterView? {
        
        let footer = t.dequeueIdentifiableHeaderFooter(FooterType.self)
        
        footer.display(data: footerDataValue)
        
        return footer
    }
    
    func headerHeight(forTable t: UITableView, forSection s: Int) -> CGFloat {
        wrappedSection.headerHeight(forTable: t, forSection: s)
    }
    
    func footerHeight(forTable t: UITableView, forSection s: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func updateCells(inTable: UITableView, forSection: Int) {
        wrappedSection.updateCells(inTable: inTable, forSection: forSection)
    }
}

struct TableCollapsibleSectionWrapper: TableSectionType {
    
    var headerData: Any? { wrappedSection.headerData }
    var footerData: Any? { wrappedSection.footerData }
    
    var wrappedSection: TableSectionType
    var isCollapsed: Bool
    var showsHeaderWhenCollapsed: Bool
    var showsFooterWhenCollapsed: Bool
    
    var cellType: UITableViewCell.Type {
        return wrappedSection.cellType
    }
    
    var itemsCount: Int {
        isCollapsed ? 0 : wrappedSection.itemsCount
    }
    
    func item(forIndex i: Int) -> Any {
        wrappedSection.item(forIndex: i)
    }
    
    func getAllItems<T>(as t: T.Type) -> [T]? {
        wrappedSection.getAllItems(as: t)
    }
    
    mutating func set(item: Any, forIndex i: Int) {
        wrappedSection.set(item: item, forIndex: i)
    }
    
    mutating func updateHeaderData(_ newValue: Any) {
        wrappedSection.updateHeaderData(newValue)
    }
    
    mutating func updateFooterData(_ newValue: Any) {
        wrappedSection.updateFooterData(newValue)
    }
    
    func prepareCell(fromTable t: UITableView, forIndexPath i: IndexPath) -> TableIdentifiableCell {
        wrappedSection.prepareCell(fromTable: t, forIndexPath: i)
    }
    
    func prepareViewForHeader(fromTable t: UITableView, forSection s: Int) -> UITableViewHeaderFooterView? {
        if isCollapsed && !showsHeaderWhenCollapsed { return nil }
        
        return wrappedSection.prepareViewForHeader(fromTable: t, forSection: s)
    }
    
    func prepareViewForFooter(fromTable t: UITableView, forSection s: Int) -> UITableViewHeaderFooterView? {
        if isCollapsed && !showsFooterWhenCollapsed { return nil }
        
        return wrappedSection.prepareViewForFooter(fromTable: t, forSection: s)
    }
    
    func headerHeight(forTable t: UITableView, forSection s: Int) -> CGFloat {
        
        if isCollapsed && !showsHeaderWhenCollapsed { return 0 }
        
        return wrappedSection.headerHeight(forTable: t, forSection: s)
    }
    
    func footerHeight(forTable t: UITableView, forSection s: Int) -> CGFloat {
        
        if isCollapsed && !showsFooterWhenCollapsed { return 0 }
        
        return wrappedSection.footerHeight(forTable: t, forSection: s)
    }
    
    func updateCells(inTable: UITableView, forSection: Int) {
        if !isCollapsed {
            wrappedSection.updateCells(inTable: inTable, forSection: forSection)
        }
    }
}

struct AnyTableSection: TableSectionType {
    
    var headerData: Any? { wrappedSection.headerData }
    var footerData: Any? { wrappedSection.footerData }
    
    var wrappedSection: TableSectionType
    
    var cellType: UITableViewCell.Type {
        return wrappedSection.cellType
    }
    
    init(section s: TableSectionType) {
        wrappedSection = s
    }
    
    var itemsCount: Int {
        return wrappedSection.itemsCount
    }
    
    func item(forIndex i: Int) -> Any {
        wrappedSection.item(forIndex: i)
    }
    
    func getAllItems<T>(as t: T.Type) -> [T]? {
        wrappedSection.getAllItems(as: t)
    }
    
    mutating func set(item: Any, forIndex i: Int) {
        wrappedSection.set(item: item, forIndex: i)
    }
    
    mutating func updateHeaderData(_ newValue: Any) {
        wrappedSection.updateHeaderData(newValue)
    }
    
    mutating func updateFooterData(_ newValue: Any) {
        wrappedSection.updateFooterData(newValue)
    }
    
    func prepareCell(fromTable t: UITableView, forIndexPath i: IndexPath) -> TableIdentifiableCell {
        wrappedSection.prepareCell(fromTable: t, forIndexPath: i)
    }
    
    func prepareViewForHeader(fromTable t: UITableView, forSection s: Int) -> UITableViewHeaderFooterView? {
        wrappedSection.prepareViewForHeader(fromTable: t, forSection: s)
    }
    
    func prepareViewForFooter(fromTable t: UITableView, forSection s: Int) -> UITableViewHeaderFooterView? {
        wrappedSection.prepareViewForFooter(fromTable: t, forSection: s)
    }
    
    func headerHeight(forTable t: UITableView, forSection s: Int) -> CGFloat {
        wrappedSection.headerHeight(forTable: t, forSection: s)
    }
    
    func footerHeight(forTable t: UITableView, forSection s: Int) -> CGFloat {
        wrappedSection.footerHeight(forTable: t, forSection: s)
    }
    
    func updateCells(inTable: UITableView, forSection: Int) {
        wrappedSection.updateCells(inTable: inTable, forSection: forSection)
    }
}
