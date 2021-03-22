//
//  InvoicePaymentViewModel.swift
//  EUBanking
//
//  Created by Avaz Abdrasulov on 18/3/21.
//

import UIKit

struct BackendModel {
    let id: Int
    let name: String
    let total: Int
}

class InvoicePaymentViewModel {
    
    let mockBackendModels: [BackendModel] = [.init(id: 1, name: "Свет", total: 10030),
                                            .init(id: 2, name: "Свет", total: 20030),
                                            .init(id: 3, name: "Свет", total: 30030),
                                            .init(id: 4, name: "Свет", total: 40030),
                                            .init(id: 5, name: "Свет", total: 40030),
                                            .init(id: 6, name: "Свет", total: 50030),
                                            .init(id: 7, name: "Свет", total: 60030),
                                            .init(id: 8, name: "Свет", total: 10030)]
    func getInvoices() -> [InvoiceCellViewModel] {
        mockBackendModels.map { $0.toViewModel() }
    }
        
}

private extension BackendModel {
    func toViewModel() -> InvoiceCellViewModel {
        let testImage = #imageLiteral(resourceName: "serviceIcon")
        let period = InvoiceParameters.PeriodModel(startValue: 1234,
                                                   endValue: 12344,
                                                   unitTitle: "кВт",
                                                   unitPrice: 100,
                                                   total: 1233413)
        let params1: [InvoiceParameters] = [.period(period), .debit(132, false), .fee(200, true), .total(3000400)]
        let params2: [InvoiceParameters] = [.period(period), .debit(132, false), .total(3000400)]
        let params3: [InvoiceParameters] = [.period(period), .total(3000400)]
        let params4: [InvoiceParameters] = [.invoice(10000)]
        
        let params = [params1, params2, params3, params4]
        return InvoiceCellViewModel(id: self.id,
                                    parametres:params1,  // params.randomElement()!,
                                    icon: testImage,
                                    title: self.name,
                                    color: .blue,
                                    showInvoice: true)
    }
}
