
import UIKit

class TotalAmountTableViewCell: UITableViewCell {
   
    @IBOutlet weak var amountTextField: UITextField!
    
    var amoundChanged: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        amountTextField.delegate = self
    }
    
    func setupCell(amount: Int) {
        amountTextField.text = String(amount)
    }
}

extension TotalAmountTableViewCell: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let amount = Int(textField.text ?? "") else { return }
        amoundChanged?(amount)
    }
}
