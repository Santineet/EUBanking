//
//  PaymentsConfirmationViewModel.swift
//  EUBanking
//
//  Created by Mairambek on 3/16/21.
//

import Foundation
import UIKit

enum PaidServiceType: String {
    case electricity = "Электроэнергия"
    case coldWater = "Холодная вода"
    case hotWater = "Горячая вода"
    case gas = "Газ"
    
    var icon: UIImage {
        switch self {
        case .electricity:
           return #imageLiteral(resourceName: "ElectricityServiceBackground")
        case .coldWater:
            return #imageLiteral(resourceName: "ElectricityServiceBackground")
        case .hotWater:
            return #imageLiteral(resourceName: "ElectricityServiceBackground")
        case .gas:
            return #imageLiteral(resourceName: "ElectricityServiceBackground")
        }
    }
}

class PaymentsConfirmationViewModel {
        
    
    var electricCollapsed: Bool = true
}
