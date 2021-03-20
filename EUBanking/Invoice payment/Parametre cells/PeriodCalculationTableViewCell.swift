
import UIKit
import RxSwift
import RxCocoa

protocol PeriodCalculationTableViewCellDelegate {
    func periodDidUpdate(period: InvoiceParameters.PeriodModel)
}

class PeriodCalculationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var startValueTextField: UITextField!
    @IBOutlet weak var endValueTextField: UITextField!
  
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountUnitLabel: UILabel!

    private var period: InvoiceParameters.PeriodModel!
    private var delegate: PeriodCalculationTableViewCellDelegate?
    
    let disposeBag = DisposeBag()
    func setup(period: InvoiceParameters.PeriodModel,
               delegate: PeriodCalculationTableViewCellDelegate) {
        self.period = period
        self.delegate = delegate
        startValueTextField.text = String(period.startValue)
        endValueTextField.text = String(period.endValue)
        amountLabel.text = String(period.endValue - period.startValue)
        amountUnitLabel.text = period.unitTitle
    }
    
    func setupTextFields() {
        startValueTextField.rx.text
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .bind { [weak self] text in
                guard let `self` = self, let text = text, let intValue = Int(text) else { return }
                self.period.startValue = intValue
                self.delegate?.periodDidUpdate(period: self.period)
                self.calculateTotalAmount()
            }.disposed(by: disposeBag)
        
        endValueTextField.rx.text
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .bind { [weak self] text in
                guard let `self` = self, let text = text, let intValue = Int(text) else { return }
                self.period.endValue = intValue
                self.delegate?.periodDidUpdate(period: self.period)
                self.calculateTotalAmount()
            }.disposed(by: disposeBag)
    }

    func calculateTotalAmount() {
        amountLabel.text = String(period.endValue - period.startValue)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTextFields()
    }
}
