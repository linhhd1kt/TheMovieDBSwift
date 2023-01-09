//
//  MenuViewController.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Domain
import RxCocoa
import RxSwift
import UIKit
import Data

public final class MenuViewController: BaseViewController, UIScrollViewDelegate {
  @IBOutlet private var tableView: UITableView!
  private let viewModel: NavigationViewModelType

  // MARK: - Initialization

  @available(*, unavailable)
  public required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public init(viewModel: NavigationViewModelType) {
    self.viewModel = viewModel
    super.init()
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
    setupLayouts()
    bindInput(viewModel.input)
    bindOutput(viewModel.output)
  }

  private func setupLayouts() {
    setupTableView()
  }

  private func setupTableView() {
    tableView.rx.setDelegate(self)
      .disposed(by: disposeBag)
    tableView.register(MenuCell.self)
    tableView.rowHeight = 40
    tableView.separatorStyle = .none
  }

  private func bindInput(_ input: NavigationViewModelInputType) {
    tableView.rx.itemSelected
      .compactMap { Screen(rawValue: $0.row) }
      .bind(to: input.navigationSelect)
      .disposed(by: disposeBag)
  }

  private func bindOutput(_ output: NavigationViewModelOutputType) {
    output.menuItems
      .bind(to: tableView.rx.items(cellIdentifier: MenuCell.className, cellType: MenuCell.self)) { _, model, cell in
        cell.configure(name: model.name)
      }
      .disposed(by: disposeBag)
  }
}
