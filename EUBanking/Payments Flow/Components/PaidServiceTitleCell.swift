//
//  PaidServiceTitleCell.swift
//  EUBanking
//
//  Created by Mairambek on 3/15/21.
//

import UIKit


struct PaidServiceTitleData {
    var title: String
    var background: UIImage
    var isCollapsed: Bool
}

class PaidServiceTitleCell: UITableViewCell, TableSectionCell, NibLoadable {
    typealias ItemType = PaidServiceTitleData
    
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var isCollapsedIcon: UIImageView!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        backgroundImageView.addBorder(toSide: .Left, withColor: UIColor.appLightGray.cgColor, andThickness: 1)
//        backgroundImageView.addBorder(toSide: .Right, withColor: UIColor.appLightGray.cgColor, andThickness: 1)
//        backgroundImageView.addBorder(toSide: .Top, withColor: UIColor.appLightGray.cgColor, andThickness: 1)
//        self.layer.cornerRadius = 10
//        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively    }
    
    func display(item: PaidServiceTitleData) {
        
    }
}
