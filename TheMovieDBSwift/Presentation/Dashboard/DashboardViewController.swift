//
//  DashboardViewController.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 19/10/2022.
//

import UIKit

class DashboardViewController: RickViewController {

    private let viewModel: DashboardViewModelType
        
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: DashboardViewModelType, navigationViewModel: NavigationViewModelType) {
        self.viewModel = viewModel
        super.init(navigationViewModel: navigationViewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindInput(viewModel.input)
        bindOutput(viewModel.output)
    }
    
    private func bindInput(_ input: DashboardViewModelInputType) {
    }

    private func bindOutput(_ output: DashboardViewModelOutputType) {
    }
}
