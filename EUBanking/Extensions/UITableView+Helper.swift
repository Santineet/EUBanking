import UIKit

extension UITableView {
	
    /// Convenient method to register NIB-based `UITableViewCell`.
    @objc func registerNib(forCellClass cellClass: ReuseIdentifierProviding.Type) {
        register(cellClass.nib, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }
	
	/// Convenient method to register NIB-based `UITableViewHeaderFooterView`.
    @objc func registerNib(forViewClass viewClass: ReuseIdentifierProviding.Type) {
        register(viewClass.nib, forHeaderFooterViewReuseIdentifier: viewClass.reuseIdentifier)
    }
    
    /// Convenient method to register class-based `UITableViewHeaderFooterView`.
    @objc func register(viewClass: ReuseIdentifierProviding.Type) {
        register(viewClass, forHeaderFooterViewReuseIdentifier: viewClass.reuseIdentifier)
    }
	
}
