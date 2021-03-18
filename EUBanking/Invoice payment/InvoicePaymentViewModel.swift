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
        return InvoiceCellViewModel(id: self.id,
                                    icon: testImage,
                                    title: self.name,
                                    color: .blue,
                                    parametres: [],
                                    showInvoice: true)
    }
}
