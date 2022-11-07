//
//  RickTableView.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 02/11/2022.
//

import UIKit
import RxSwift

protocol RickTableViewType {
    var input: RickTableViewInputType { get }
    var output: RickTableViewOutputType { get }
}

protocol RickTableViewInputType {
    var startFetch: AnyObserver<Void> { get }
}
protocol RickTableViewOutputType {
}

class RickTableView: UITableView {
    // FIXME: use service facade to inject viewmodel here: https://somethinglink.info
//    private let viewModel: RickTableViewModelType = RickTableViewModel()
//    private let startFetchObserver = PublishSubject<Void>()
//    private let resultObserver = PublishSubject<[Movie]>()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }
    
    private func configure() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = R.color.secondary()
        rx.setDelegate(self).disposed(by: disposeBag)
        register(MovieTableCell.self)
        rowHeight = 40
        separatorStyle = .none
//        bindInput(viewModel.input)
//        bindOutput(viewModel.output)
    }
    
//    private func bindInput(_ input: RickTableViewModelInputType) {
//        startFetchObserver
//            .debug("XXX starFeth")
//            .bind(to: input.startFetch)
//            .disposed(by: disposeBag)
//    }
//    private func bindOutput(_ output: RickTableViewModelOutputType) {
//        output.fetchResult
//            .debug("XXX fetchResult")
//            .bind(to: rx.items(cellIdentifier: MovieTableCell.className, cellType: MovieTableCell.self)) { _, model, cell in
//                cell.configure(model)
//            }
//            .disposed(by: disposeBag)
//    }
}

//extension RickTableView: RickTableViewInputType {
//    var startFetch: AnyObserver<Void> {
//        return startFetchObserver.asObserver()
//    }
//}
//extension RickTableView: RickTableViewOutputType { }
//
//extension RickTableView: RickTableViewType {
//    var input: RickTableViewInputType {
//        return self
//    }
//    var output: RickTableViewOutputType {
//        return self
//    }
//}
//
extension RickTableView: HasDisposeBag { }
//
extension RickTableView: UIScrollViewDelegate { }
