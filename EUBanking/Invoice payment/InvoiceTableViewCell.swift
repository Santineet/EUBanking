//
//  InvoiceTableViewCell.swift
//  EUBanking
//
//  Created by Avaz Abdrasulov on 17/3/21.
//

import UIKit

protocol InvoiceTableViewCellDelegate: class {
    func updateInvoice(_ updatedInvoice: InvoiceCellViewModel)
}

class InvoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var parametresTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var showInvoiceViewConstraint: NSLayoutConstraint!
   
    @IBOutlet weak var checkBoxImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var roundedContainerView: UIView! {
        didSet {
            roundedContainerView.layer.cornerRadius = 12.0
            roundedContainerView.layer.borderWidth = 0.7
            roundedContainerView.layer.masksToBounds = true
            roundedContainerView.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    @IBOutlet weak var showInvoiceView: UIView! {
        didSet {
            showInvoiceView.layer.masksToBounds = true
            showInvoiceView.layer.cornerRadius = 8.0
            showInvoiceView.layer.borderWidth = 0.7
            showInvoiceView.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    @IBOutlet weak var parametresTableView: ContentSizedTableView! {
        didSet {
            parametresTableView.registerNib(forCellClass: PeriodCalculationTableViewCell.self)
            parametresTableView.registerNib(forCellClass: DebitTableViewCell.self)
            parametresTableView.registerNib(forCellClass: FeeTableViewCell.self)
            parametresTableView.registerNib(forCellClass: TotalAmountTableViewCell.self)
            parametresTableView.registerNib(forCellClass: InvoiceAmountTableViewCell.self)
        }
    }
    
    var invoice: InvoiceCellViewModel!
    weak var delegate: InvoiceTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(invoice: InvoiceCellViewModel, delegate: InvoiceTableViewCellDelegate) {
        self.invoice = invoice
        self.delegate = delegate
        self.titleLabel.text = invoice.title
        parametresTableView.reloadData()
        setupCollapse()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupCollapse() {
        self.checkBoxImageView.image = self.invoice.isSelected ? #imageLiteral(resourceName: "checkBoxOn") : #imageLiteral(resourceName: "checkBoxOff")
        self.tableView?.beginUpdates()
        self.parametresTableViewHeightConstraint.isActive = !self.invoice.isSelected
        self.showInvoiceViewConstraint.isActive = !self.invoice.isSelected
        self.tableView?.endUpdates()
        
    }
    
    func updateTotalCell() {
        guard let index = self.invoice.parametres.firstIndex(where: {
            if case .total = $0 { return true } else { return false }
        }) else { return }

        guard let totalCell = parametresTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? TotalAmountTableViewCell else {
            return
        }

        let updatedTotal = invoice.parametres.calculateTotal()
        amoundChanged(value: updatedTotal)
        totalCell.setupCell(amount: updatedTotal, delegate: self)
}
    
    @IBAction func headerTapped() {
        self.invoice.isSelected = !invoice.isSelected
        delegate?.updateInvoice(self.invoice)
        setupCollapse()
    }
    
}
 
extension InvoiceTableViewCell: UITableViewDelegate {
    
}

extension InvoiceTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("updated")
        return invoice.parametres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch invoice.parametres[indexPath.row] {
        case .period(let period):
            let cell = PeriodCalculationTableViewCell.dequeue(from: tableView, for: indexPath)!
            cell.setup(period: period, delegate: self)
            return cell
        case .debit(let amount, let state):
            let cell = DebitTableViewCell.dequeue(from: tableView, for: indexPath)!
            cell.setupCell(debitAmount: amount, enabled: state, delegate: self)
            return cell
        case .fee(let amount, let state):
            let cell = FeeTableViewCell.dequeue(from: tableView, for: indexPath)!
            cell.setupCell(feeAmount: amount, enabled: state, delegate: self)
            return cell
        case .total(let amount):
            let cell = TotalAmountTableViewCell.dequeue(from: tableView, for: indexPath)!
            cell.setupCell(amount: amount, delegate: self)
            return cell
        case .invoice(let amount):
            let cell = InvoiceAmountTableViewCell.dequeue(from: tableView, for: indexPath)!
            cell.setupCell(amount: amount)
            return cell
        }
    }
}

extension InvoiceTableViewCell: PeriodCalculationTableViewCellDelegate {
    func periodDidUpdate(period: InvoiceParameters.PeriodModel) {
        guard let index = self.invoice.parametres.firstIndex(where: {
            if case .period = $0 { return true } else { return false }
        }) else { return }
        
        invoice.parametres[index] = InvoiceParameters.period(period)
        updateTotalCell()
        delegate?.updateInvoice(self.invoice)
        
    }
}

extension InvoiceTableViewCell: DebitTableViewCellDelegate {
    func payDebitSwitchDidChange(state: Bool, amount: Int) {
        guard let index = self.invoice.parametres.firstIndex(where: {
            if case .debit = $0 { return true } else { return false }
        }) else { return }
        
        invoice.parametres[index] = InvoiceParameters.debit(amount, state)
        delegate?.updateInvoice(self.invoice)
        updateTotalCell()
    }
}

extension InvoiceTableViewCell: FeeTableViewCellDelegate {
    func payFeeSwitchDidChange(state: Bool, amount: Int) {
        guard let index = self.invoice.parametres.firstIndex(where: {
            if case .fee = $0 { return true } else { return false }
        }) else { return }
        
        invoice.parametres[index] = InvoiceParameters.fee(amount, state)
        delegate?.updateInvoice(self.invoice)
        updateTotalCell()
    }
}

extension InvoiceTableViewCell: TotalAmountTableViewCellDelegate {
    func amoundChanged(value: Int) {
        guard let index = self.invoice.parametres.firstIndex(where: {
            if case .total = $0 { return true} else { return false }
        }) else { return }
        self.invoice.parametres[index] = .total(value)
        self.delegate?.updateInvoice(self.invoice)
    }
    
    
}
