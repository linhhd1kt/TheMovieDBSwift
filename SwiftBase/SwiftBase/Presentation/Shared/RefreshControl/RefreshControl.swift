//
//  RefreshControl.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Foundation
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
//        refreshControl.tintColor = design.style.colors.surfaceTint
    refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
    self.refreshControl = refreshControl

    if #available(iOS 10.0, *) {
      tableView.refreshControl = refreshControl
    } else {
      tableView.backgroundView = refreshControl
    }
  }
}

class RefreshHandler: NSObject {
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
