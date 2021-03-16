//
//  UICollectionViewFlowLayout+ProductGrid.swift
//  Magnet
//
//  Created by Mairambek on 2/22/21.
//

import UIKit

extension UICollectionViewFlowLayout {
    
    static func gridLayout(forCollection collectionView: UICollectionView) -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        
        let cellsPerRow: CGFloat = 2
        
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 16
        
//        let collectionInsets = collectionView.adjustedContentInset
//        let contentBounds = collectionView.bounds.inset(by: collectionInsets)
        let contentBounds = UIScreen.main.bounds
        
        let cellWidth = (contentBounds.size.width - layout
                            .sectionInset.left - layout
                            .sectionInset.right) / cellsPerRow
            - layout.minimumInteritemSpacing * (cellsPerRow - 1)
        
        let cellHeight = cellWidth * 1.49
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        return layout
    }
}
