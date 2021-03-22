//
//  InvoiceAmountTableViewCell.swift
//  EUBanking
//
//  Created by Avaz Abdrasulov on 22/3/21.
//

import UIKit

class InvoiceAmountTableViewCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    
    func setupCell(amount: Int) {
        amountLabel.text = String(amount)
    }
  
}
