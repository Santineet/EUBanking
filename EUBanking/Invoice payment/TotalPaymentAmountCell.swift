//
//  TotalPaymentAmountCell.swift
//  EUBanking
//
//  Created by Mairambek on 3/20/21.
//

import UIKit

class TotalPaymentAmountCell: UITableViewCell {
 
    @IBOutlet private weak var payButton: UIButton!
    
    func setupCell(amount: Int) {
        payButton.setTitle("\(amount) T", for: .normal)
    }
}
