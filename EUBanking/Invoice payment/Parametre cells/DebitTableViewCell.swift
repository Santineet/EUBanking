
import UIKit
import RxSwift
import RxCocoa

protocol DebitTableViewCellDelegate: class {
    func payDebitSwitchDidChange(state: Bool, amount: Int)
}

class DebitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var debitAmountLabel: UILabel!
    @IBOutlet weak var paySwitch: UISwitch!
    private weak var delegate: DebitTableViewCellDelegate?
    private let disposeBag = DisposeBag()
    private var debitAmount = 0
   
    func setupCell(debitAmount: Int, enabled: Bool, delegate: DebitTableViewCellDelegate) {
        debitAmountLabel.text = String(debitAmount)
        self.delegate = delegate
        self.debitAmount = debitAmount
        paySwitch.isOn = enabled
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        paySwitch.rx.isOn.bind { [weak self] in
            guard let `self` = self else { return }
            self.delegate?.payDebitSwitchDidChange(state: $0, amount: self.debitAmount)
        }.disposed(by: disposeBag)
    }
}
