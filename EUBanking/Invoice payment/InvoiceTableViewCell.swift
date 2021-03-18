//
//  InvoiceTableViewCell.swift
//  EUBanking
//
//  Created by Avaz Abdrasulov on 17/3/21.
//

import UIKit

class InvoiceTableViewCell: UITableViewCell {

    var invoice: InvoiceCellViewModel!
    @IBOutlet weak var parametresTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var showInvoiceViewConstraint: NSLayoutConstraint!
   
    @IBOutlet weak var checkBoxImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var parametresTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(invoice: InvoiceCellViewModel) {
        self.invoice = invoice
        self.titleLabel.text = invoice.title
        self.iconImageView.image = invoice.icon
        self.checkBoxImageView.image = invoice.isSelected ? #imageLiteral(resourceName: "checkBoxOn") : #imageLiteral(resourceName: "checkBoxOff")
    }
    
    @IBAction func headerTapped() {
        self.invoice.isSelected = !invoice.isSelected
        self.checkBoxImageView.image = invoice.isSelected ? #imageLiteral(resourceName: "checkBoxOn") : #imageLiteral(resourceName: "checkBoxOff")
        
        self.tableView?.beginUpdates()
        self.parametresTableViewHeightConstraint.isActive = !invoice.isSelected
        self.showInvoiceViewConstraint.isActive = !invoice.isSelected
        self.tableView?.endUpdates()
    }
    
}
 
extension InvoiceTableViewCell: UITableViewDelegate {
    
}

extension InvoiceTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        invoice.parametres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        return cell
    }
    
    
    
}
