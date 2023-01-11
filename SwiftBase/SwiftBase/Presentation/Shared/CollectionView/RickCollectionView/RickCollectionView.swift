//
//  RickCollectionView.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import MJRefresh
import RxCocoa
import RxDataSources
import RxSwift
import Domain
import Services
import Extension
import Data
import Design

class RickCollectionView<Page: Paginated>: UICollectionView {
  private let reloadObserver = PublishSubject<Void>()
  private let itemsObserver = BehaviorRelay<Page>(value: .init())

  // MARK: - Input
  private let resultObserver = PublishSubject<Page>()
  private let resetObserver = PublishSubject<Void>()

  // MARK: - Output
  private let nextPageObserver = PublishSubject<Int>()

  var logger: Logger {
    guard let logger = ServiceFacade.getService(LoggerType.self) as? Logger else {
      fatalError("Logger should be implemented!")
    }
    return logger
  }
  
  var design: DesignType {
    guard let design = ServiceFacade.getService(DesignType.self) else {
      fatalError("Design should be implemented!")
    }
    return design
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
  }

  convenience init() {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 160, height: 320)
    layout.scrollDirection = .horizontal
    layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
    layout.minimumLineSpacing = 0
    self.init(frame: .zero, collectionViewLayout: layout)
    contentInsetAdjustmentBehavior = .never
    backgroundColor = .clear
    logger.debug("\(className) is initialized.")
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

    // clear all items
    resetObserver
      .map { Page() }
      .bind(to: itemsObserver)
      .disposed(by: disposeBag)
  }

  func configure<Element, Cell: UICollectionViewCell>(
    identifier _: String,
    type _: Cell.Type,
    configureCell: @escaping (IndexPath, Element, Cell) -> Void
  ) where Page.Element == Element {
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

  deinit {
    logger.debug("\(className) is release.")
  }
}

extension RickCollectionView: RickCollectionViewInputType {
  var itemsResult: AnyObserver<Page> {
    resultObserver.asObserver()
  }

  var reset: AnyObserver<Void> {
    return resetObserver.asObserver()
  }
}

extension RickCollectionView: RickCollectionViewOutputType {
  var nextPageTrigger: Observable<Int> {
    return nextPageObserver.asObservable()
  }
}

extension RickCollectionView: HasDisposeBag {}
