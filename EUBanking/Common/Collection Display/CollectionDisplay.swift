//
//  CollectionDisplay.swift
//  Magnet
//
//  Created by Mairambek on 2/14/21.
//

import UIKit

enum CollectionReusableViewSizing {
    case collectionLayoutBased
    case fullWidthScreenHeight
    case fullWidthFixedHeight(CGFloat)
    case custom(CGSize)
    case calculated(() -> CGSize)
}

protocol CollectionSectionType {
    var headerData: Any? { get }
    var footerData: Any? { get }
    
    var itemsCount: Int { get }
    
    var cellType: UICollectionViewCell.Type { get }
    
    func item(forIndex: Int) -> Any
    
    func getAllItems<T>(as: T.Type) -> [T]?
    
    mutating func set(item: Any, forIndex: Int)
    
    var cellSizing: CollectionReusableViewSizing { get }
    var headerSizing: CollectionReusableViewSizing { get }
    var footerSizing: CollectionReusableViewSizing { get }
    
    func prepareCell(fromCollection: UICollectionView, forIndexPath: IndexPath) -> CollectionIdentifiableCell
    
    func prepareSupplementaryView(fromCollection: UICollectionView, ofKind: String, forIndexPath: IndexPath) -> UICollectionReusableView
}

protocol CollectionSectionCell: UICollectionViewCell, CollectionIdentifiable {
    associatedtype ItemType
    
    func display(item: ItemType)
}

protocol CollectionSectionHeader: CollectionIdentifiable {
    associatedtype DataType
    
    func display(data: DataType)
}

protocol CollectionSectionFooter: CollectionIdentifiable {
    associatedtype DataType
    
    func display(data: DataType)
}

struct CollectionSection<CellType: CollectionSectionCell>: CollectionSectionType {
    
    var headerData: Any? { nil }
    var footerData: Any? { nil }
    
    var itemsCount: Int {
        return items.count
    }
    
    var cellType: UICollectionViewCell.Type {
        return CellType.self
    }
    
    private(set) var cellSizing: CollectionReusableViewSizing
    var headerSizing: CollectionReusableViewSizing { .custom(.zero) }
    var footerSizing: CollectionReusableViewSizing { .custom(.zero) }
    
    var items: [CellType.ItemType]
    
    init(items i: [CellType.ItemType], sizing: CollectionReusableViewSizing, cellType: CellType.Type) {
        items = i
        cellSizing = sizing
    }
    
    func item(forIndex i: Int) -> Any { items[i] }
    
    func getAllItems<T>(as: T.Type) -> [T]? { return items as? [T] }
    
    mutating func set(item: Any, forIndex i: Int) {
        if let newItem = item as? CellType.ItemType {
            items[i] = newItem
        }
    }
    
    func prepareCell(fromCollection c: UICollectionView, forIndexPath i: IndexPath) -> CollectionIdentifiableCell {
        
        let cell = c.dequeueIdentifiableCell(CellType.self, for: i)
        let item = items[i.item]
        
        cell.display(item: item)
        
        return cell
    }
    
    func prepareSupplementaryView(fromCollection: UICollectionView, ofKind: String, forIndexPath: IndexPath) -> UICollectionReusableView {
        fatalError()
    }
}

//struct CollectionShimmeringSection: CollectionSectionType {
//    
//    var headerData: Any? { nil }
//    var footerData: Any? { nil }
//    
//    private(set) var itemsCount: Int
//    private(set) var cellSizing: CollectionReusableViewSizing
//    var headerSizing: CollectionReusableViewSizing { .custom(.zero) }
//    var footerSizing: CollectionReusableViewSizing { .custom(.zero) }
//    
//    var cellType: UICollectionViewCell.Type {
//        return CollectionShimmerCell.self
//    }
//    
//    init(itemsCount count: Int, cellSizing sizing: CollectionReusableViewSizing) {
//        itemsCount = count
//        cellSizing = sizing
//    }
//    
//    func item(forIndex i: Int) -> Any { () }
//    
//    func getAllItems<T>(as: T.Type) -> [T]? { nil }
//    
//    mutating func set(item: Any, forIndex i: Int) { }
//    
//    func prepareCell(fromCollection c: UICollectionView, forIndexPath i: IndexPath) -> CollectionIdentifiableCell {
//        c.dequeueIdentifiableCell(CollectionShimmerCell.self, for: i)
//    }
//    
//    func prepareSupplementaryView(fromCollection: UICollectionView, ofKind: String, forIndexPath: IndexPath) -> UICollectionReusableView {
//        fatalError()
//    }
//}

struct CollectionEndSection<CellType: CollectionSectionCell>: CollectionSectionType {
    
    var headerData: Any? { nil }
    var footerData: Any? { nil }
    
    let itemsCount: Int = 1
    let cellSizing: CollectionReusableViewSizing
    var headerSizing: CollectionReusableViewSizing { .custom(.zero) }
    var footerSizing: CollectionReusableViewSizing { .custom(.zero) }
    
    var cellType: UICollectionViewCell.Type {
        return CellType.self
    }
    
    init(sizing: CollectionReusableViewSizing, cellType: CellType.Type) {
        cellSizing = sizing
    }
    
    func item(forIndex i: Int) -> Any { () }
    
    func getAllItems<T>(as: T.Type) -> [T]? { nil }
    
    mutating func set(item: Any, forIndex i: Int) { }
    
    func prepareCell(fromCollection c: UICollectionView, forIndexPath i: IndexPath) -> CollectionIdentifiableCell {
        c.dequeueIdentifiableCell(CellType.self, for: i)
    }
    
    func prepareSupplementaryView(fromCollection: UICollectionView, ofKind: String, forIndexPath: IndexPath) -> UICollectionReusableView {
        fatalError()
    }
}

struct CollectionEmptySection: CollectionSectionType {
    
    static let shared = CollectionEmptySection()
    
    var headerData: Any? { nil }
    
    var footerData: Any? { nil }
    
    var cellType: UICollectionViewCell.Type { fatalError("Should never happen") }
    
    let itemsCount: Int = 0
    var cellSizing: CollectionReusableViewSizing { .custom(.zero) }
    var headerSizing: CollectionReusableViewSizing { .custom(.zero) }
    var footerSizing: CollectionReusableViewSizing { .custom(.zero) }
    
    func prepareCell(fromCollection: UICollectionView, forIndexPath: IndexPath) -> CollectionIdentifiableCell {
        fatalError("Should never happen")
    }
    
    func item(forIndex: Int) -> Any { () }
    
    func getAllItems<T>(as: T.Type) -> [T]? { nil }
    
    mutating func set(item: Any, forIndex: Int) { }
    
    func prepareSupplementaryView(fromCollection: UICollectionView, ofKind: String, forIndexPath: IndexPath) -> UICollectionReusableView {
        fatalError("Should never happen")
    }
    
    func sizeForSupplementaryView(fromCollection: UICollectionView, ofKind: String, forIndexPath: IndexPath) -> CGSize {
        fatalError("Should never happen")
    }
}

extension CollectionSectionType {
    
    func withHeader<HeaderType: CollectionSectionHeader>(
        headerData d: HeaderType.DataType,
        headerSizing hs: CollectionReusableViewSizing,
        headerType: HeaderType.Type
    ) -> CollectionSectionType {
    
        CollectionSectionHeaderWrapper(section: self, headerData: d, headerSizing: hs, headerType: HeaderType.self)
    }
    
    func withFooter<FooterType: CollectionSectionFooter>(
        footerData d: FooterType.DataType,
        footerSizing fs: CollectionReusableViewSizing,
        footerType: FooterType.Type
    ) -> CollectionSectionType {
    
        CollectionSectionFooterWrapper(section: self, footerData: d, footerSizing: fs, footerType: FooterType.self)
    }
    
    func indexPaths(forSection s: Int) -> [IndexPath] {
        (0..<itemsCount).map { (i) -> IndexPath in
            IndexPath(row: i, section: s)
        }
    }
}

struct CollectionSectionHeaderWrapper<HeaderType: CollectionSectionHeader>: CollectionSectionType {
    
    var wrappedSection: CollectionSectionType
    var headerDataValue: HeaderType.DataType
    
    var headerData: Any? { headerDataValue }
    
    var footerData: Any? { wrappedSection.footerData }
    
    var cellType: UICollectionViewCell.Type {
        return wrappedSection.cellType
    }
    
    var itemsCount: Int {
        wrappedSection.itemsCount
    }
    
    var cellSizing: CollectionReusableViewSizing { wrappedSection.cellSizing }
    
    private(set) var headerSizing: CollectionReusableViewSizing
    
    var footerSizing: CollectionReusableViewSizing { wrappedSection.footerSizing }
    
    init(
        section s: CollectionSectionType,
        headerData d: HeaderType.DataType,
        headerSizing hs: CollectionReusableViewSizing,
        headerType: HeaderType.Type
    ) {
        wrappedSection = s
        headerDataValue = d
        headerSizing = hs
    }
    
    func prepareCell(fromCollection c: UICollectionView, forIndexPath i: IndexPath) -> CollectionIdentifiableCell {
        wrappedSection.prepareCell(fromCollection: c, forIndexPath: i)
    }
    
    func item(forIndex i: Int) -> Any {
        wrappedSection.item(forIndex: i)
    }
    
    func getAllItems<T>(as t: T.Type) -> [T]? { wrappedSection.getAllItems(as: t)}
    
    mutating func set(item: Any, forIndex i: Int) {
        wrappedSection.set(item: item, forIndex: i)
    }
    
    func prepareSupplementaryView(fromCollection c: UICollectionView, ofKind k: String, forIndexPath i: IndexPath) -> UICollectionReusableView {
        
        if k == UICollectionView.elementKindSectionHeader {
            let header = c.dequeueIdentifiableSupplementary(HeaderType.self, ofKind: k, for: i)
            header.display(data: headerDataValue)
            return header
        } else {
            return wrappedSection.prepareSupplementaryView(fromCollection: c, ofKind: k, forIndexPath: i)
        }
    }
}

struct CollectionSectionFooterWrapper<FooterType: CollectionSectionFooter>: CollectionSectionType {
    
    var wrappedSection: CollectionSectionType
    var footerDataValue: FooterType.DataType
    
    var headerData: Any? { wrappedSection.headerData }
    
    var footerData: Any? { footerDataValue }
    
    var cellType: UICollectionViewCell.Type {
        return wrappedSection.cellType
    }
    
    var itemsCount: Int {
        wrappedSection.itemsCount
    }
    
    var cellSizing: CollectionReusableViewSizing {
        wrappedSection.cellSizing
    }
    
    var headerSizing: CollectionReusableViewSizing { wrappedSection.headerSizing }
    
    private(set) var footerSizing: CollectionReusableViewSizing
    
    init(
        section s: CollectionSectionType,
        footerData d: FooterType.DataType,
        footerSizing fs: CollectionReusableViewSizing,
        footerType: FooterType.Type
    ) {
        wrappedSection = s
        footerDataValue = d
        footerSizing = fs
    }
    
    func prepareCell(fromCollection c: UICollectionView, forIndexPath i: IndexPath) -> CollectionIdentifiableCell {
        wrappedSection.prepareCell(fromCollection: c, forIndexPath: i)
    }
    
    func item(forIndex i: Int) -> Any {
        wrappedSection.item(forIndex: i)
    }
    
    func getAllItems<T>(as t: T.Type) -> [T]? { wrappedSection.getAllItems(as: t)}
    
    mutating func set(item: Any, forIndex i: Int) {
        wrappedSection.set(item: item, forIndex: i)
    }
    
    func prepareSupplementaryView(fromCollection c: UICollectionView, ofKind k: String, forIndexPath i: IndexPath) -> UICollectionReusableView {
        
        if k == UICollectionView.elementKindSectionFooter {
            let header = c.dequeueIdentifiableSupplementary(FooterType.self, ofKind: k, for: i)
            header.display(data: footerDataValue)
            return header
        } else {
            return wrappedSection.prepareSupplementaryView(fromCollection: c, ofKind: k, forIndexPath: i)
        }
    }
}
