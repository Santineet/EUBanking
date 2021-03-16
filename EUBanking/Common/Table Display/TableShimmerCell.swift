//
//  TableShimmerCell.swift
//  Magnet
//
//  Created by Mairambek on 2/14/21.
//

//import UIKit
//import Shimmer
//
//class TableShimmerCell: UITableViewCell, TableSectionCell {
//    typealias ItemType = Void
//    
//    let shimmeringView = FBShimmeringView()
//    let brickView = UIView()
//    
//    func display(item: Void) {}
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
//        backgroundColor = .clear
//        
//        shimmeringView.translatesAutoresizingMaskIntoConstraints = false
//        
//        contentView.addSubview(shimmeringView)
//        contentView.backgroundColor = .clear
//        
//        NSLayoutConstraint.activate([
//            shimmeringView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
//            shimmeringView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
//            shimmeringView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            shimmeringView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
//        ])
//        
//        shimmeringView.shimmeringBeginFadeDuration = 0.3
//        shimmeringView.shimmeringOpacity = 0.3
//        shimmeringView.isShimmering = true
//        
//        brickView.translatesAutoresizingMaskIntoConstraints = false
//        
//        brickView.backgroundColor = .lightGray
//        brickView.layer.cornerRadius = 8
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
