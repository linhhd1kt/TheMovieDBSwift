//
//  UITableView+Ex.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 30/10/2022.
//

import UIKit
import RxSwift
import RxCocoa

extension UITableView {
    func register<T: UITableViewCell>(_ type: T.Type, bundle: Bundle? = nil) {
        let className = type.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func register<T: UITableViewHeaderFooterView>(_ type: T.Type, bundle: Bundle? = nil) {
        let className = type.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: className)
    }
    
    func dequeue<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T else {
            fatalError("Cast to \(type.className) failed")
        }
        return cell
    }
    
    func dequeue<T: UITableViewCell>(_ type: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.className) as? T else {
            fatalError("Cast to \(type.className) failed")
        }
        return cell
    }
    
    func dequeue<T: UITableViewHeaderFooterView>(_ type: T.Type) -> T {
        guard let section = dequeueReusableHeaderFooterView(withIdentifier: type.className) as? T else {
            fatalError("Cast to \(type.className) failed")
        }
        return section
    }
    
    func cellForRow<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = cellForRow(at: indexPath) as? T else {
            fatalError("Cast to \(type.className) failed")
        }
        return cell
    }
    
    func header<T: UITableViewHeaderFooterView>(_ type: T.Type) -> T {
        guard let header = tableHeaderView as? T else {
            fatalError("Cast to \(type.className) failed")
        }
        return header
    }
    
    func footer<T: UITableViewHeaderFooterView>(_ type: T.Type) -> T {
        guard let header = tableFooterView as? T else {
            fatalError("Cast to \(type.className) failed")
        }
        return header
    }
}
