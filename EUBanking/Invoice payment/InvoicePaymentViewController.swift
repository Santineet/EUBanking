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
    case debit(Int)
    case fee(Int)
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
            tableView.allowsSelection = false
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
       
        return 1
    }
    
}

extension InvoicePaymentViewController: UITableViewDelegate {
    
}

extension InvoicePaymentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        invoices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = InvoiceTableViewCell.dequeue(from: tableView, for: indexPath)!
        cell.setupCell(invoice: invoices[indexPath.row], delegate: self)
        return cell
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
