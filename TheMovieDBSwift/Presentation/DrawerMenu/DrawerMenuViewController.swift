//
//  DrawerMenuViewController.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 18/10/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DrawerMenuViewController: BaseViewController, UIScrollViewDelegate {
    @IBOutlet weak var tableView: UITableView!    
    private let viewModel: NavigationViewModelType
        
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: NavigationViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
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
        tableView.register(UINib(nibName: DrawerMenuCell.className, bundle: nil), forCellReuseIdentifier: DrawerMenuCell.className)
        tableView.rowHeight = 40
        tableView.separatorStyle = .none
    }
    
    private func bindInput(_ input: NavigationViewModelInputType) {
        tableView.rx.itemSelected        
            .compactMap { DrawerMenuScreen(rawValue: $0.row) }
            .bind(to: input.navigationSelect)
            .disposed(by: disposeBag)
    }

    private func bindOutput(_ output: NavigationViewModelOutputType) {
        output.menuItems
            .bind(to: tableView.rx.items(cellIdentifier: DrawerMenuCell.className, cellType: DrawerMenuCell.self)) { row, model, cell in
                cell.selectionStyle = .none
                cell.menuItemLabel.text = model.name
            }
            .disposed(by: disposeBag)
    }
}
