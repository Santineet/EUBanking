//
//  PaidServiceTitleCell.swift
//  EUBanking
//
//  Created by Mairambek on 3/15/21.
//

import UIKit

struct PaidServiceCollapseState {
    var type: PaidServiceType
    var isCollapsed: Bool
}

class PaidServiceCollapseControllCell: UITableViewCell, TableSectionCell, NibLoadable {
    typealias ItemType = PaidServiceCollapseState
    
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var isCollapsedIcon: UIImageView!
            
    func display(item: PaidServiceCollapseState) {
        titleLabel.text = item.type.rawValue
        backgroundImageView.image = item.type.icon
    }
}
