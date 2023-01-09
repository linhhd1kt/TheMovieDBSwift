//
//  RefreshControl.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import UIKit

@objc protocol Refreshable {
  var refreshControl: UIRefreshControl? { get set }
  var tableView: UITableView { get set }
  @objc func handleRefresh(_ sender: Any)
}

extension Refreshable where Self: UIViewController {
  func installRefreshControl() {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
    self.refreshControl = refreshControl
    tableView.refreshControl = refreshControl
  }
}

public final class RefreshHandler: NSObject {
  let refresh = PublishSubject<Void>()
  let refreshControl = UIRefreshControl()

  init(view: UIScrollView) {
    super.init()
    view.addSubview(refreshControl)
    refreshControl.addTarget(self, action: #selector(refreshControlDidRefresh(_:)), for: .valueChanged)
  }

  @objc func refreshControlDidRefresh(_: UIRefreshControl) {
    refresh.onNext(())
  }

  func end() {
    refreshControl.endRefreshing()
  }
}
