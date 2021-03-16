//
//  PaymentsConfirmationViewController.swift
//  EUBanking
//
//  Created by Mairambek on 3/15/21.
//

import UIKit

class PaymentsConfirmationViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var sections: [TableSectionType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        sections = buildSetions()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNibLoadableCell(PaidServiceTitleCell.self)
        tableView.registerNibLoadableCell(ConsumptionCalculationCell.self)
        tableView.registerNibLoadableCell(IncludeOverpaymentCell.self)
        tableView.registerNibLoadableCell(PaymentAmountCell.self)
    }
    
    private func buildSetions() -> [TableSectionType] {
        [
            TableSection(items: [PaidServiceTitleData(title: "Электричество", background: #imageLiteral(resourceName: "ElectricityServiceBackground"), isCollapsed: false)], cellType: PaidServiceTitleCell.self)
        ]
    }
}

extension PaymentsConfirmationViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sections[indexPath.section].prepareCell(fromTable: tableView, forIndexPath: indexPath)
                
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = sections[section].prepareViewForHeader(fromTable: tableView, forSection: section)
        
//        if let collapsibleHeader = header as? ExperienceDetailsWhatsInsideCollapsibleHeader {
//            collapsibleHeader.tapHandler = { [unowned self] in
//                self.handleCollapseControlHeaderTap(forSection: section)
//            }
//        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return sections[section].prepareViewForFooter(fromTable: tableView, forSection: section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].headerHeight(forTable: tableView, forSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sections[section].footerHeight(forTable: tableView, forSection: section)
    }

    // MARK: UITableViewDelegate - logical part
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        
        return false
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        let item = sections[indexPath.section].item(forIndex: indexPath.row)
//
//        if item is RadioButtoninfo {
//            handleRadioButtonCellSelection(forIndexPath: indexPath)
//        } else if item is HowToExperienceInfo {
//            handleHowToExperienceCellSelection(forIndexPath: indexPath)
//        } else if item is CollapseState {
//            handleCollapseControlCellSelection(forIndexPath: indexPath)
//        } else if let additionalInfoItem = item as? ItemAdditionalInfoFieldType {
//            additionalInfoItem.action?()
//        }
    }

}
