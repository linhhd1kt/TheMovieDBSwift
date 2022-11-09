//
//  RickTableView.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 02/11/2022.
//

import UIKit
import RxSwift
import RxCocoa

class TableView: UITableView {

    init() {
        super.init(frame: CGRect(), style: .plain)
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        makeUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }

    func makeUI() {
        rowHeight = UITableView.automaticDimension
        backgroundColor = .clear
        if #available(iOS 11.0, *) {
            estimatedRowHeight = 0
            estimatedSectionHeaderHeight = 0
            estimatedSectionFooterHeight = 0
        }
        keyboardDismissMode = .onDrag
        separatorStyle = .none
    }

    func updateUI() {
        setNeedsDisplay()
    }
}

class RickTableView<Page: Paginated>: UITableView {
    private let reloadObserver = PublishSubject<Void>()
    private let movieSelectedObserver = PublishSubject<Movie?>()
    let nextPageObserver = PublishSubject<Int>()
    
    // MARK: - Input
    let resultObserver = BehaviorRelay<Page>(value: .init())
        
    // MARK: - Output
    var nextPageTrigger: Observable<Int> {
        return nextPageObserver.asObservable()
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
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = R.color.secondary()
//        rx.setDelegate(self).disposed(by: disposeBag)
        register(MovieTableCell.self)
        rowHeight = 40
        separatorStyle = .none
    }

    func binding() {
        rx.reachEnd
            .debug("XXX reachEnd")
            .withLatestFrom(resultObserver.map(\.page))
            .debug("XXX reachEnd withLatestFrom resultObserver")
            .filter { $0 < 5 || $0 == 0 } // stop loading when first 5 page
            .map { $0 + 1 } // increase page by 1 when loading next page
            .debug("XXX reachEnd next page")
            .bind(to: nextPageObserver)
            .disposed(by: disposeBag)
        resultObserver
            .debug("XXX RickTableView show items")
            .map(\.results)
            .bind(to: rx.items(cellIdentifier: MovieTableCell.className, cellType: MovieTableCell.self)) { _, model, cell in
                if let model = model as? Movie {
                    cell.configure(model)
                }
            }
            .disposed(by: disposeBag)
//        output.loading
//            .bind(to: rx.loading)
//            .disposed(by: disposeBag)
//        if let refreshControl = tableView.refreshControl {
//            output.loading
//                .bind(to: refreshControl.rx.isRefreshing)
//                .disposed(by: disposeBag)
//        }
    }
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
//extension RickTableView: UIScrollViewDelegate { }
