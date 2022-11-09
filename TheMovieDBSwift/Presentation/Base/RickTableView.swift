//
//  RickTableView.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 02/11/2022.
//

import UIKit
import RxSwift
import RxCocoa

class RickTableView<Page: Paginated>: UITableView {
    private let reloadObserver = PublishSubject<Void>()    
    private let itemsObserver = BehaviorRelay<Page>(value: .init())

    // MARK: - Input
    private let resultObserver = PublishSubject<Page>()
        
    // MARK: - Output
    private let nextPageObserver = PublishSubject<Int>()
    
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
        rowHeight = 40
        separatorStyle = .none
    }

    func binding() {
        rx.reachEnd
            .withLatestFrom(resultObserver)
            .filter { $0.page <= $0.totalPages || $0.page == 0 }
            .map(\.page)
            .map { $0 + 1 }
            .bind(to: nextPageObserver)
            .disposed(by: disposeBag)
        
        // replace all items with first page items (eg: first load, reload)
        resultObserver
            .filter { $0.page == 1 }
            .do { [weak self] _ in
                self?.refreshControl?.endRefreshing()
            }
            .bind(to: itemsObserver)
            .disposed(by: disposeBag)
        // when load next page append data to existing items
        resultObserver
            .filter { $0.page > 1 }
            .bind(to: itemsObserver.append)
            .disposed(by: disposeBag)
        
        if let refreshControl = self.refreshControl {
            refreshControl.rx.controlEvent(.valueChanged)
                .map { 1 }
                .bind(to: nextPageObserver)
                .disposed(by: disposeBag)
        }
    }
    
    func configure<Element, Cell: UITableViewCell>(
        identifier: String,
        type: Cell.Type,
        configureCell: @escaping (Int, Element, Cell) -> Void)
    where Page.Element == Element {
        itemsObserver
            .map(\.results)
            .bind(to: rx.items(cellIdentifier: identifier, cellType: type)) { index, model, cell in
                configureCell(index, model, cell)
            }
            .disposed(by: disposeBag)
    }
}

protocol RickTableViewInputType {
    associatedtype Page
    var itemsResult: AnyObserver<Page> { get }
}

protocol RickTableViewOutputType {
    var nextPageTrigger: Observable<Int> { get }
}

extension RickTableView: RickTableViewInputType {
    var itemsResult: AnyObserver<Page> {
        resultObserver.asObserver()
    }
}
extension RickTableView: RickTableViewOutputType {
    var nextPageTrigger: Observable<Int> {
        return nextPageObserver.asObservable()
    }
}

extension RickTableView: HasDisposeBag { }
