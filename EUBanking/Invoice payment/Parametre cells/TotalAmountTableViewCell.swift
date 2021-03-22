
import UIKit

protocol TotalAmountTableViewCellDelegate: class {
    func amoundChanged(value: Int)
}

class TotalAmountTableViewCell: UITableViewCell {
   
    @IBOutlet weak var amountTextField: UITextField!
    
    weak var delegate: TotalAmountTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        amountTextField.delegate = self
    }
    
    func setupCell(amount: Int, delegate: TotalAmountTableViewCellDelegate) {
        self.delegate = delegate
        self.amountTextField.text = String(amount)
    }
}

extension TotalAmountTableViewCell: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let amount = Int(textField.text ?? "") else { return }
        delegate?.amoundChanged(value: amount)
    }
}
