//
//  ItemSessionView.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 30/10/2022.
//

import UIKit
import RxSwift
import RxDataSources

class ItemSessionView: UIView {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var sessionTitleLabel: UILabel!
    @IBOutlet private weak var dropdownTableView: UITableView!
    @IBOutlet private weak var dropdownHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var itemsContainer: UIView!
    fileprivate var itemsCollectionView = RickCollectionView<MoviePage>()
    
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
        dropdownTableView.backgroundColor = R.color.secondary()
        dropdownTableView.cornerRadius = ItemSessionView.dropdownItemHeight / 2
        dropdownTableView.separatorStyle = .none
        dropdownTableView.isScrollEnabled = false
        dropdownTableView.layer.cornerRadius = ItemSessionView.dropdownItemHeight / 2
        dropdownTableView.backgroundColor = R.color.secondary()
    }
    
    private func setupItemsCollectionView() {
        itemsContainer.attach(itemsCollectionView)
        itemsCollectionView.register(MovieCollectionCell.self)
        itemsCollectionView.configure(identifier: MovieCollectionCell.className, type: MovieCollectionCell.self) { _, model, cell in
            cell.configure(model)
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
            .map({ items, display, selectedItem in
                if display {
                    return [selectedItem] + items.filter { $0.title != selectedItem.title }
                } else {
                    return [selectedItem]
                }
            })
        // show dropdown items
        items.map { [CategorySession(header: "What's popular", items: $0)] }
            .bind(to: dropdownTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        // fix size of dropdown
        items.map { CGFloat($0.count) * ItemSessionView.dropdownItemHeight }
            .bind(to: dropdownHeightConstraint.rx.constant)
            .disposed(by: disposeBag)
        // binding selected dropdown item
        dropdownTableView.rx.modelSelected(DiscoverCategory.self)
            .bind(to: selectedCategoryObserver)
            .disposed(by: disposeBag)
        // binding next page trigger
        itemsCollectionView.nextPageTrigger
            .bind(to: nextPageTriggerObserver)
            .disposed(by: disposeBag)
        // selected distinct category
        let selectedCategory = selectedCategoryObserver
            .distinctUntilChanged()
            .map { _ in 1 }
        // binding next page trigger
        selectedCategory
            .bind(to: nextPageTriggerObserver)
            .disposed(by: disposeBag)
        // scroll collection view to left when category selected
        selectedCategory
            .withUnretained(self)
            .subscribe {  this, _ in
                this.itemsCollectionView.setContentOffset(.init(x: 0, y: 0), animated: true)
            }.disposed(by: disposeBag)
    }
}

extension ItemSessionView: HasDisposeBag {}

extension Reactive where Base: ItemSessionView {
    // input
    var items: AnyObserver<MoviePage> {
        return base.itemsCollectionView.itemsResult
    }
    // output
    var selectedCategory: Observable<DiscoverCategory> {
        return base.selectedCategoryObserver.asObservable()
    }
    var nextPage: Observable<Int> {
        return base.nextPageTriggerObserver.asObservable()
    }
}
