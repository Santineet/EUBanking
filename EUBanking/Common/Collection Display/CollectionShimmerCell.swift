//
//  CollectionShimmerCell.swift
//  Magnet
//
//  Created by Mairambek on 2/14/21.
//

//import UIKit
//import Shimmer
//
//class CollectionShimmerCell: UICollectionViewCell, CollectionSectionCell {
//    typealias ItemType = Void
//    
//    let shimmeringView = FBShimmeringView()
//    let brickView = UIView()
//    
//    func display(item: Void) {}
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        prepare()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        
//        prepare()
//    }
//    
//    private func prepare() {
//        shimmeringView.translatesAutoresizingMaskIntoConstraints = false
//        
//        contentView.addSubview(shimmeringView)
//        
//        NSLayoutConstraint.activate([
//            shimmeringView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            shimmeringView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            shimmeringView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            shimmeringView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//        
//        shimmeringView.shimmeringBeginFadeDuration = 0.3
//        shimmeringView.shimmeringOpacity = 0.3
//        shimmeringView.isShimmering = true
//        
//        brickView.translatesAutoresizingMaskIntoConstraints = false
//        
//        brickView.backgroundColor = .lightGray
//        brickView.layer.cornerRadius = 12
//        brickView.layer.masksToBounds = true
//        
//        shimmeringView.contentView = brickView
//        
//        NSLayoutConstraint.activate([
//            brickView.leadingAnchor.constraint(equalTo: shimmeringView.leadingAnchor),
//            brickView.trailingAnchor.constraint(equalTo: shimmeringView.trailingAnchor),
//            brickView.topAnchor.constraint(equalTo: shimmeringView.topAnchor),
//            brickView.bottomAnchor.constraint(equalTo: shimmeringView.bottomAnchor)
//        ])
//    }
//}
