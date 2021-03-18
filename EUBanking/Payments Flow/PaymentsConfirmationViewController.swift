////
////  PaymentsConfirmationViewController.swift
////  EUBanking
////
////  Created by Mairambek on 3/15/21.
////
//
//import UIKit
//
//class PaymentsConfirmationViewController: UIViewController {
//
//    @IBOutlet private weak var tableView: UITableView!
//
//    private var sections: [TableSectionType] = []
//
//    private var viewModel = PaymentsConfirmationViewModel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupTableView()
//        sections = buildSetions()
//    }
//
//    private func setupTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.registerNibLoadableCell(PaidServiceCollapseControllCell.self)
//        tableView.registerNibLoadableCell(ConsumptionCalculationCell.self)
//        tableView.registerNibLoadableCell(IncludeOverpaymentCell.self)
//        tableView.registerNibLoadableCell(PaymentAmountCell.self)
//    }
//
//    private func buildSetions() -> [TableSectionType] {
//        [
//            buildElectricCollapseSection(),
//            buildColdWoterCollapseSection(),
//            buildHotWoterCollapseSection()
//        ]
//    }
//
//    private func buildElectricCollapseSection() -> TableSectionType {
//        TableSection(items: [PaidServiceCollapseState(
//                                type: .electricity,
//                                isCollapsed: viewModel.electricCollapsed)],
//                     cellType: PaidServiceCollapseControllCell.self)
//    }
//
//    private func buildColdWoterCollapseSection() -> TableSectionType {
//        TableSection(items: [PaidServiceCollapseState(
//                                type: .coldWater,
//                                isCollapsed: viewModel.electricCollapsed)],
//                     cellType: PaidServiceCollapseControllCell.self)
//    }
//
//    private func buildHotWoterCollapseSection() -> TableSectionType {
//        TableSection(items: [PaidServiceCollapseState(
//                                type: .coldWater,
//                                isCollapsed: viewModel.electricCollapsed)],
//                     cellType: PaidServiceCollapseControllCell.self)
//    }
//
//    private func buildElectricServiceInfoSections() -> [TableSectionType] {
//        [
//            TableSection(items: [ConsumptionCalculationsData()],
//                         cellType: ConsumptionCalculationCell.self),
//            TableSection(items: [()], cellType: IncludeOverpaymentCell.self),
//            TableSection(items: [()], cellType: PaymentAmountCell.self)
//        ]
//    }
//
//    private func buildColdWoterInfoSections() -> [TableSectionType] {
//        [
//            TableSection(items: [ConsumptionCalculationsData()],
//                         cellType: ConsumptionCalculationCell.self),
//            TableSection(items: [()], cellType: IncludeOverpaymentCell.self),
//            TableSection(items: [()], cellType: PaymentAmountCell.self)
//        ]
//    }
//
//    private func buildHotWoterInfoSections() -> [TableSectionType] {
//        [
//            TableSection(items: [ConsumptionCalculationsData()],
//                         cellType: ConsumptionCalculationCell.self),
//            TableSection(items: [()], cellType: IncludeOverpaymentCell.self),
//            TableSection(items: [()], cellType: PaymentAmountCell.self)
//        ]
//    }
//
//    private func handleElectricCollapseSelection(forIndexPath idxPath: IndexPath, forSections collapsedSections: [TableSectionType]) {
//        if var collapseSection = sections[idxPath.section] as? TableSection<PaidServiceCollapseControllCell> {
//            var collapseItem = collapseSection.items[idxPath.row]
//            let changedRange = idxPath.section + 1 ... idxPath.section + collapsedSections.count
//
//            if !collapseItem.isCollapsed {
//                collapseItem.isCollapsed = true
//                let indexSet = IndexSet(integersIn: changedRange)
//                sections.removeSubrange(changedRange)
//                tableView.deleteSections(indexSet, with: .top)
//                tableView.beginUpdates()
//                tableView.endUpdates()
//            } else {
//                collapseItem.isCollapsed = false
//
//                sections.insert(contentsOf: collapsedSections, at: idxPath.section + 1)
//
//                let idxSet = IndexSet(integersIn: changedRange)
//
//                tableView.insertSections(idxSet, with: .top)
//            }
//
//            viewModel.electricCollapsed = collapseItem.isCollapsed
//            collapseSection.items[idxPath.row] = collapseItem
//            sections[idxPath.section] = collapseSection
//            if let collapseControlCell = tableView.cellForRow(at: idxPath) as? PaidServiceCollapseControllCell {
//                collapseControlCell.display(item: collapseItem)
//            }
//        }
//    }
//}
//
//extension PaymentsConfirmationViewController: UITableViewDelegate, UITableViewDataSource {
//
//    // MARK: - UITableViewDataSource
//    func numberOfSections(in tableView: UITableView) -> Int {
//        sections.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        sections[section].itemsCount
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = sections[indexPath.section].prepareCell(fromTable: tableView, forIndexPath: indexPath)
//
//        return cell
//    }
//
//
//    // MARK: - UITableViewDelegate
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = sections[section].prepareViewForHeader(fromTable: tableView, forSection: section)
//
//        return header
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return sections[section].prepareViewForFooter(fromTable: tableView, forSection: section)
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return sections[section].headerHeight(forTable: tableView, forSection: section)
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return sections[section].footerHeight(forTable: tableView, forSection: section)
//    }
//
//    // MARK: UITableViewDelegate - logical part
//    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = sections[indexPath.section].item(forIndex: indexPath.row)
//        if let callapsibleItem = item as? PaidServiceCollapseState {
//            switch callapsibleItem.type {
//            case .electricity:
//                handleElectricCollapseSelection(forIndexPath: indexPath, forSections: [])
//            default:
//                break
//            }
//        }
//    }
//}
