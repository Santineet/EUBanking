
import UIKit

class TotalAmountTableViewCell: UITableViewCell {
    @IBOutlet weak var amountLabel: UITextField!
    
    func setupCell(amount: Int) {
        amountLabel.text = String(amount)
    }
}
