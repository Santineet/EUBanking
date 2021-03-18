
import UIKit

class DebitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var debitAmountLabel: UILabel!
    @IBOutlet weak var payDepitSwitch: UISwitch!
    
    func setupCell(debitAmount: Int, enabled: Bool) {
        debitAmountLabel.text = String(debitAmount)
        payDepitSwitch.isOn = enabled
    }
}
