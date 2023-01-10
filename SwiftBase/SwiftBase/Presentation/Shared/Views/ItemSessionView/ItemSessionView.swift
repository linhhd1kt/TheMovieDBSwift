//
//  ItemSessionView.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Design
import RxDataSources
import RxSwift
import Domain
import Extension
import Data

public struct CategorySession {
  public var header: String
  public var items: [Item]
}

extension CategorySession: SectionModelType {
  public typealias Item = DiscoverCategory

  public init(original: CategorySession, items: [Item]) {
    self = original
    self.items = items
  }
}

class ItemSessionView: UIView {
  @IBOutlet private var contentView: UIView!
  @IBOutlet private var sessionTitleLabel: UILabel!
  @IBOutlet private var dropdownTableView: UITableView!
  @IBOutlet private var dropdownHeightConstraint: NSLayoutConstraint!
  @IBOutlet private var itemsContainer: UIView!
  fileprivate var itemsCollectionView = RickCollectionView<MediaPage>()

  private let expandDropdownObserver = BehaviorSubject<Bool>(value: false)

  // MARK: - Input

  fileprivate let categoryListObserver = PublishSubject<[DiscoverCategory]>()
  fileprivate let selectedCategoryObserver = PublishSubject<DiscoverCategory>()

  // MARK: - Output

  fileprivate let nextPageTriggerObserver = BehaviorSubject<Int>(value: 1)

  static let dropdownItemHeight: CGFloat = 32.0

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  private func setup() {
    loadFromXib()
    configureLayouts()
    binding()
  }

  /// set title and category for item section
  func configure(title: String, categories: [DiscoverCategory]) {
    sessionTitleLabel.text = title
    selectedCategoryObserver.onNext(categories.first ?? .streaming)
    Observable.just(categories)
      .bind(to: categoryListObserver)
      .disposed(by: disposeBag)
  }

  private func configureLayouts() {
    configureDropdown()
    setupItemsCollectionView()
  }

  /// configure dropdown
  private func configureDropdown() {
    dropdownTableView.register(CategoryDropdownCell.self)
    dropdownTableView.register(SelectedCategoryDropdownCell.self)
    dropdownTableView.rowHeight = ItemSessionView.dropdownItemHeight
    dropdownTableView.backgroundColor = design.style.colors.secondary
    dropdownTableView.cornerRadius = ItemSessionView.dropdownItemHeight / 2
    dropdownTableView.separatorStyle = .none
    dropdownTableView.isScrollEnabled = false
    dropdownTableView.layer.cornerRadius = ItemSessionView.dropdownItemHeight / 2
  }

  private func setupItemsCollectionView() {
    itemsContainer.attach(itemsCollectionView)
    itemsCollectionView.register(MediaCollectionCell.self)
    itemsCollectionView.configure(identifier: MediaCollectionCell.className, type: MediaCollectionCell.self) { _, model, cell in
      cell.configure(model as! Movie)
    }
    itemsCollectionView.binding()
  }

  private func binding() {
    bindingDropdown()
  }

  private func bindingDropdown() {
    // expand or collapse dropdown
    selectedCategoryObserver
      .scan(true) { lastState, _ in !lastState }
      .bind(to: expandDropdownObserver)
      .disposed(by: disposeBag)
    // dropdown data source setup
    let dataSource = RxTableViewSectionedReloadDataSource<CategorySession> { _, tableView, indexPath, item in
      if indexPath.row == 0 {
        let cell = tableView.dequeue(SelectedCategoryDropdownCell.self)
        cell.configure(item.title)
        return cell
      } else {
        let cell = tableView.dequeue(CategoryDropdownCell.self)
        cell.configure(item.title)
        return cell
      }
    }
    // expand/collapse dropdown items base on selected category
    let items: Observable<[DiscoverCategory]> = PublishSubject
      .combineLatest(categoryListObserver, expandDropdownObserver, selectedCategoryObserver)
      .map { items, display, selectedItem in
        if display {
          return [selectedItem] + items.filter { $0.title != selectedItem.title }
        } else {
          return [selectedItem]
        }
      }
    // show dropdown items
    items.map { [CategorySession(header: "What's popular", items: $0)] }
      .bind(to: dropdownTableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
    // fix size of dropdown
    items.map { CGFloat($0.count) * ItemSessionView.dropdownItemHeight }
      .bind(to: dropdownHeightConstraint.rx.constant)
      .disposed(by: disposeBag)
    // binding selected dropdown item
    let modelSelected = dropdownTableView.rx.modelSelected(DiscoverCategory.self)
      .share()
    // binding model selected to selected category
    modelSelected
      .bind(to: selectedCategoryObserver)
      .disposed(by: disposeBag)
    // selected distinct category
    let distinctModelSelected = modelSelected
      .skip(1)
      .distinctUntilChanged()
      .map { _ in 1 }
    // binding next page trigger
    distinctModelSelected
      .bind(to: nextPageTriggerObserver)
      .disposed(by: disposeBag)
    // scroll collection view to left when category selected
    distinctModelSelected
      .withUnretained(self)
      .subscribe { this, _ in
        this.itemsCollectionView.setContentOffset(.init(x: 0, y: 0), animated: true)
      }.disposed(by: disposeBag)
    // binding next page trigger
    itemsCollectionView.nextPageTrigger
      .bind(to: nextPageTriggerObserver)
      .disposed(by: disposeBag)
  }
}

extension ItemSessionView: HasDisposeBag, HasDeSign {}

extension Reactive where Base: ItemSessionView {
  // input
  var items: AnyObserver<MediaPage> {
    return base.itemsCollectionView.itemsResult
  }
  // output
  var selectedCategory: Observable<DiscoverCategory> {
    return base.selectedCategoryObserver
      .asObservable()
      .distinctUntilChanged()
  }
  var nextPage: Observable<Int> {
    return base.nextPageTriggerObserver
      .asObservable()
  }
}
