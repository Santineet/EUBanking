
import UIKit
import RxSwift
import RxCocoa

protocol FeeTableViewCellDelegate: class {
    func payFeeSwitchDidChange(state: Bool, amount: Int)
}

class FeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var feeAmountLabel: UILabel!
    @IBOutlet weak var payFeeSwitch: UISwitch!
    private weak var delegate: FeeTableViewCellDelegate?
    private let disposeBag = DisposeBag()
    private var feeAmount = 0
    
    func setupCell(feeAmount: Int, enabled: Bool, delegate: FeeTableViewCellDelegate) {
        feeAmountLabel.text = String(feeAmount)
        self.delegate = delegate
        payFeeSwitch.isOn = enabled
        self.feeAmount = feeAmount
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        payFeeSwitch.rx.isOn.bind { [weak self] in
            guard let `self` = self else { return }
            self.delegate?.payFeeSwitchDidChange(state: $0, amount: self.feeAmount)
        }.disposed(by: disposeBag)
    }
}
