//
//  RickTableView.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 02/11/2022.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

class RickTableView<Page: Paginated>: UITableView {
    private let reloadObserver = PublishSubject<Void>()
    private let itemsObserver = BehaviorRelay<Page>(value: .init())

    // MARK: - Input
    private let resultObserver = PublishSubject<Page>()
        
    // MARK: - Output
    private let nextPageObserver = PublishSubject<Int>()
    
    var logger: Logger {
        guard let logger = ServiceFacade.getService(Logable.self) as? Logger else {
            fatalError("Logger should be implemented!")
        }
        return logger
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }
    
    private func configure() {
        configureLayouts()
        configureRefreshControl()
        configureSpiner()
        logger.debug("\(className) is initialized.")
    }
    
    private func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = design.style.colors.primary
    }
    
    private func configureLayouts() {
        rowHeight = 140.0
        separatorStyle = .none
    }

    private func configureSpiner() {
        let footer = MJRefreshAutoNormalFooter()
        footer.loadingView?.color = design.style.colors.secondary
        footer.stateLabel?.textColor = design.style.colors.secondary
        mj_footer = footer
    }

    func binding() {
        rx.reachEnd
            .withLatestFrom(resultObserver)
            .filter { $0.page <= $0.totalPages || $0.page == 0 }
            .map(\.page)
            .map { $0 + 1 }
            .bind(to: nextPageObserver)
            .disposed(by: disposeBag)
        
        resultObserver
            .withUnretained(self)
            .subscribe { this, _ in
                this.refreshControl?.endRefreshing()
            }
            .disposed(by: disposeBag)

        // replace all items with first page items (eg: first load, reload)
        resultObserver
            .filter { $0.page == 1 }
            .bind(to: itemsObserver)
            .disposed(by: disposeBag)

        // when load next page append data to existing items
        resultObserver
            .filter { $0.page > 1 }
            .bind(to: itemsObserver.append)
            .disposed(by: disposeBag)
        // pull to refresh to clear and load table view again
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
    
    deinit {
        logger.debug("\(className) is release.")
    }
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
