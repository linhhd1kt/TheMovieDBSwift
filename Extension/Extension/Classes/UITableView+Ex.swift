//
//  UITableView+Ex.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

public extension UITableView {
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

  ///
  /// using this function when register cell from pod
  ///
  func registerFromPod<T: UITableViewCell>(_: T.Type, from controller: UIViewController) {
    let podBundle = Bundle(for: T.classForCoder())
    guard let bundleURL = podBundle.url(forResource: controller.moduleName, withExtension: "bundle") else {
      fatalError("Cound not get bundle url from Domain!")
    }
    guard let bundle = Bundle(url: bundleURL) else {
      fatalError("Could not initial bundle from \(bundleURL)")
    }
    let nib = UINib(nibName: T.className, bundle: bundle)
    guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
      fatalError("Could not load view from bundle \(bundle.className)")
    }
    register(nib, forCellReuseIdentifier: T.className)
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
