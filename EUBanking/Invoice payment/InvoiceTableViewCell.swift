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
    @IBOutlet weak var parametresTableView: UITableView! {
        didSet {
            parametresTableView.registerNib(forCellClass: PeriodCalculationTableViewCell.self)
            parametresTableView.registerNib(forCellClass: DebitTableViewCell.self)
            parametresTableView.registerNib(forCellClass: TotalAmountTableViewCell.self)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(invoice: InvoiceCellViewModel) {
        self.invoice = invoice
        self.titleLabel.text = invoice.title
        setupCollapse()
        parametresTableView.reloadData()
    }
    
    func setupCollapse() {
       
        UIView.animate(withDuration: 0.3) {
            self.checkBoxImageView.image = self.invoice.isSelected ? #imageLiteral(resourceName: "checkBoxOn") : #imageLiteral(resourceName: "checkBoxOff")

            self.tableView?.beginUpdates()
            self.parametresTableViewHeightConstraint.isActive = !self.invoice.isSelected
            self.showInvoiceViewConstraint.isActive = !self.invoice.isSelected
            self.tableView?.endUpdates()
        }
       
    }
    
    @IBAction func headerTapped() {
        self.invoice.isSelected = !invoice.isSelected
        setupCollapse()
    }
    
}
 
extension InvoiceTableViewCell: UITableViewDelegate {
    
}

extension InvoiceTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        invoice.parametres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch invoice.parametres[indexPath.row] {
        case .period(let period):
            let cell = PeriodCalculationTableViewCell.dequeue(from: tableView, for: indexPath)!
            return cell
        case .debit(let amount):
            let cell = DebitTableViewCell.dequeue(from: tableView, for: indexPath)!
            cell.setupCell(debitAmount: amount, enabled: true)
            return cell
        case .fee(let amount):
            let cell = DebitTableViewCell.dequeue(from: tableView, for: indexPath)!
            cell.setupCell(debitAmount: amount, enabled: true)
            return cell
        case .total(let amount):
            let cell = TotalAmountTableViewCell.dequeue(from: tableView, for: indexPath)!
            cell.setupCell(amount: amount)
            return cell
        case .invoice(_):
            return UITableViewCell()
        }
       
    }
    
    
    
}
