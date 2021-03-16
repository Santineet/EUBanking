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
        let total: String
    }
    case invoice(Int)
    case period(PeriodModel)
    case debit(Int)
    case fee(Int)
    case total(Int)
}

struct InvoiceViewModel {
    let id: Int
    var isSelected = false
    let icon: UIImage
    let title: String
    let color: UIColor // Добавь сюда градиент
    let parametres: [InvoiceParameters] = []
    let showInvoice: Bool
}

class InvoicePaymentViewController: UIViewController {
    
    var viewModels: [InvoiceViewModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func getTotal() -> Int {
       
        return 1
    }
    
}

extension InvoicePaymentViewController: UITableViewDelegate {
    
}

extension InvoicePaymentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        return cell
    }
    
    
    
}
