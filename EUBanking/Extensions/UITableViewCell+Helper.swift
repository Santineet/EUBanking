import UIKit

/// Protocol for Table View cells which provide their reuse identifier.
@objc protocol ReuseIdentifierProviding: class {
    
    /// Returns cell reuse identifier. Default is cell `class name`.
    static var reuseIdentifier: String { get }
    
    /// Returns cell NIB name. Default is same as `reuseIdentifier`.
    static var nibName: String { get }
    
    /// Returns cell NIB, if available.
    static var nib: UINib? { get }
    
}


extension UITableViewCell: ReuseIdentifierProviding {
    
    class var reuseIdentifier: String {
        return "\(self)"
    }
    
    class var nibName: String {
        return reuseIdentifier
    }
    
    class var nib: UINib? {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    /// Dequeues cell from specified Table View.
    @objc static func dequeue(from tableView: UITableView, for indexPath: IndexPath? = nil) -> Self? {
        return _dequeue(from: tableView, for: indexPath)
    }
    
    /// Dequeues cell and casts it to run-time type of protocol implementor.
    private static func _dequeue<T>(from tableView: UITableView, for indexPath: IndexPath? = nil) -> T? {
        var cell: UITableViewCell?
        if let indexPath = indexPath {
            cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        }
        return cell as? T
    }
    
    var tableView: UITableView? {
        get {
            var table: UIView? = superview
            while !(table is UITableView) && table != nil {
                table = table?.superview
            }
            
            return table as? UITableView
        }
    }
    
    func updateVisibleCells() {
        UIView.setAnimationsEnabled(false)
        tableView?.beginUpdates()
        tableView?.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
    
    
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

extension UITableViewHeaderFooterView: ReuseIdentifierProviding {
    
    class var reuseIdentifier: String {
        return "\(self)"
    }
    
    class var nibName: String {
        return reuseIdentifier
    }
    
    class var nib: UINib? {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    /// Dequeues cell from specified Table View.
    @objc static func dequeue(from tableView: UITableView) -> Self? {
        return _dequeue(from: tableView)
    }
    
    /// Dequeues view and casts it to run-time type of protocol implementor.
    private static func _dequeue<T>(from tableView: UITableView) -> T? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier)
        return view as? T
    }
    
}

