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
    
    private let viewModel: DrawerMenuViewModelType
        
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: DrawerMenuViewModelType = DrawerMenuViewModel()) {
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
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func bindInput(_ input: DrawerMenuViewModelInputType) {
        
//        Observable.just(DrawerMenuScreen.allCases)
//            .bind(to: input.menuSelect)
//        tableView.rx.itemSelected
//            .bind(to: input.menuSelect)
//            .disposed(by: disposeBag)
//

//        usernameTextField.rx.text
//            .filterNil()
//            .bind(to: input.username)
//            .disposed(by: disposeBag)
//        passwordTextField.rx.text
//            .filterNil()
//            .bind(to: input.password)
//            .disposed(by: disposeBag)
//        loginButton.rx.tap
//            .bind(to: input.loginAction)
//            .disposed(by: disposeBag)
    }

    private func bindOutput(_ output: DrawerMenuViewModelOutputType) {
//        tableView.rx.itemSelected
//            .subscribe(onNext: { [weak self] indexPath in
//                guard let self = self else { return }
//                self.selectedRow = indexPath.row
//                self.tableView.reloadData()
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                    self.dismiss(animated: true) {
//                        let selectedScreen = DrawerMenuScreen(rawValue: indexPath.row) ?? .dashboard
//                        self.viewModel?.didSelectScreen.onNext(selectedScreen)
//                    }
//                }
//            })
//            .disposed(by: disposeBag)
        output.menuItems
            .bind(to: tableView.rx.items(cellIdentifier: DrawerMenuCell.className, cellType: DrawerMenuCell.self)) { row, model, cell in
                cell.selectionStyle = .none
                cell.menuItemLabel.text = model.rawValue
            }
            .disposed(by: disposeBag)
    }
}
