//
//  RickCollectionView.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 02/11/2022.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh
import RxDataSources

class RickCollectionView<Page: Paginated>: UICollectionView {
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
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configure()
    }
    
    private func configure() {
        configureLayouts()
    }
    
    private func configureLayouts() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160, height: 320)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
        layout.minimumLineSpacing = 0
        collectionViewLayout = layout
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
            }.disposed(by: disposeBag)
        
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
    }
    
    func configure<Element, Cell: UICollectionViewCell>(
        identifier: String,
        type: Cell.Type,
        configureCell: @escaping (IndexPath, Element, Cell) -> Void)
    where Page.Element == Element {
        let dataSource = RxCollectionViewSectionedReloadDataSource<ItemSession<Element>>(
            configureCell: { _, collectionView, indexPath, item in
                let cell = collectionView.dequeue(Cell.self, for: indexPath)
                configureCell(indexPath, item, cell)
                return cell
            })
        itemsObserver
            .map(\.results)
            .map { [ItemSession(title: "Popular", items: $0)] }
            .bind(to: rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
  }
}

extension RickCollectionView: RickCollectionViewInputType {
    var itemsResult: AnyObserver<Page> {
        resultObserver.asObserver()
    }
}
extension RickCollectionView: RickCollectionViewOutputType {
    var nextPageTrigger: Observable<Int> {
        return nextPageObserver.asObservable()
    }
}

extension RickCollectionView: HasDisposeBag { }