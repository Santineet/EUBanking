//
//  InvoicePaymentViewController.swift
//  EUBanking
//
//  Created by Avaz Abdrasulov on 16/3/21.
//

import UIKit

enum InvoiceParameters {
    struct PeriodModel {
        let startValue: Int
        let endValue: Int
        let unitTitle: String
        let total: Int
    }
    case invoice(Int)
    case period(PeriodModel)
    case debit(Int)
    case fee(Int)
    case total(Int)
}

struct InvoiceCellViewModel {
    let id: Int
    var isSelected = false
    let icon: UIImage
    let title: String
    let color: UIColor // Добавь сюда градиент
    let parametres: [InvoiceParameters]
    let showInvoice: Bool
}

class InvoicePaymentViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 56
            tableView.rowHeight = UITableView.automaticDimension
            tableView.registerNib(forCellClass: InvoiceTableViewCell.self)
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
        cell.setupCell(invoice: invoices[indexPath.row])
        return cell
    }

}
