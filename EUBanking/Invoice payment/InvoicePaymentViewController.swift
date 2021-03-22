//
//  InvoicePaymentViewController.swift
//  EUBanking
//
//  Created by Avaz Abdrasulov on 16/3/21.
//

import UIKit

enum InvoiceParameters {
    struct PeriodModel {
        var startValue: Int
        var endValue: Int
        let unitTitle: String
        let unitPrice: Int
        var total: Int
    }
    case invoice(Int)
    case period(PeriodModel)
    case debit(Int, Bool)
    case fee(Int, Bool)
    case total(Int)
}

struct InvoiceCellViewModel {
    let id: Int
    var isSelected = true
    var parametres: [InvoiceParameters]
    let icon: UIImage
    let title: String
    let color: UIColor // Добавь сюда градиент
    let showInvoice: Bool
}

class InvoicePaymentViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 56
            tableView.rowHeight = UITableView.automaticDimension
            tableView.registerNib(forCellClass: InvoiceTableViewCell.self)
            tableView.registerNib(forCellClass: TotalPaymentAmountCell.self)
            tableView.allowsSelection = false
            tableView.tableFooterView = UIView()
        }
    }
    
    private var invoices: [InvoiceCellViewModel] = []
    private let viewModel = InvoicePaymentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        invoices = viewModel.getInvoices()
        tableView.reloadData()
    }
    
    func getTotal() -> Int {
        let total = invoices.map({ $0.parametres.getTotal() }).reduce(0, +)
                
        return total
    }
    
}

extension InvoicePaymentViewController: UITableViewDelegate {
    
}

extension InvoicePaymentViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return invoices.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = InvoiceTableViewCell.dequeue(from: tableView, for: indexPath)!
            cell.setupCell(invoice: invoices[indexPath.row], delegate: self)
            return cell
        } else {
            let cell = TotalPaymentAmountCell.dequeue(from: tableView, for: indexPath)!
            cell.setupCell(amount: getTotal())
            return cell
        }
    }
}

extension InvoicePaymentViewController: InvoiceTableViewCellDelegate {
    func updateInvoice(_ updatedInvoice: InvoiceCellViewModel) {
        guard let index = self.invoices.firstIndex(where: { $0.id == updatedInvoice.id }) else {
            return
        }
        invoices[index] = updatedInvoice
    }
    
}

extension Array where Element == InvoiceParameters {
    func getTotal() -> Int {
        for param in self {
            switch param {
            case .total(let amount): return amount
            case .invoice(let amount): return amount
            default: break
            }
        }
        return 0
    }

    func calculateTotal() -> Int {
        var totalAmount = 0
        for param in self {
            switch param {
            case .period(let period):
                let units = period.endValue - period.startValue
                let price = units * period.unitPrice
                totalAmount += Swift.max(0, price)
            case .debit(let amount, let included):
                totalAmount += included ? amount : 0
            case .fee(let amount, let included):
                totalAmount += included ? amount : 0
            case .total(_):
                break
            case .invoice(let amount):
                totalAmount = amount
            }
        }
        return totalAmount
    }
}
