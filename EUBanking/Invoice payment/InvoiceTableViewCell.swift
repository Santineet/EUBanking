//
//  InvoiceTableViewCell.swift
//  EUBanking
//
//  Created by Avaz Abdrasulov on 17/3/21.
//

import UIKit

class InvoiceTableViewCell: UITableViewCell {

    var viewModel: InvoiceViewModel!
    @IBOutlet weak var parametresTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var showInvoiceViewConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(viewModel: InvoiceViewModel) {
        

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
 
extension InvoiceTableViewCell: UITableViewDelegate {
    
}

extension InvoiceTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.parametres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        return cell
    }
    
    
    
}
