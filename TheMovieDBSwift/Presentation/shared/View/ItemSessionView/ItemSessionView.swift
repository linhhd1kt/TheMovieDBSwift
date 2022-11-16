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

    fileprivate let categoryListObserver = PublishSubject<[DiscoverCategory]>()
    fileprivate let initialCategoryObserver = PublishSubject<DiscoverCategory>()
    fileprivate let selectedCategoryObserver = PublishSubject<DiscoverCategory>()
    private let expandDropdownObserver = BehaviorSubject<Bool>(value: false)
    
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
    
    private func configureDropdown() {
        dropdownTableView.register(CategoryDropdownCell.self)
        dropdownTableView.register(SelectedCategoryDropdownCell.self)
        dropdownTableView.rowHeight = 32
        dropdownTableView.backgroundColor = R.color.secondary()
        dropdownTableView.cornerRadius = 16
        dropdownTableView.separatorStyle = .none
        dropdownTableView.isScrollEnabled = false
        dropdownTableView.layer.cornerRadius = 16
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
        bindingItems()
    }
    
    private func bindingDropdown() {
        selectedCategoryObserver
            .scan(true) { lastState, _ in !lastState }
            .bind(to: expandDropdownObserver)
            .disposed(by: disposeBag)
        
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
        let items: Observable<[DiscoverCategory]> =
        Observable
            .combineLatest(categoryListObserver.asObservable(),
                           expandDropdownObserver.asObservable(),
                           selectedCategoryObserver.asObservable())
            .map({ items, display, selectedItem in
                if display {
                    return [selectedItem] + items.filter { $0.title != selectedItem.title }
                } else {
                    return [selectedItem]
                }
            })
        items.map { [CategorySession(header: "Popular Categories", items: $0)] }
            .bind(to: dropdownTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        items.map { CGFloat($0.count) * ItemSessionView.dropdownItemHeight }
            .bind(to: dropdownHeightConstraint.rx.constant)
            .disposed(by: disposeBag)
        dropdownTableView.rx.modelSelected(DiscoverCategory.self)
            .bind(to: selectedCategoryObserver)
            .disposed(by: disposeBag)
    }
    
    private func bindingItems() {
    }
}

extension ItemSessionView: HasDisposeBag {}

extension Reactive where Base: ItemSessionView {
    var selectedCategory: Observable<DiscoverCategory> {
        return base.selectedCategoryObserver.asObservable()
    }
    var nextPage: Observable<Int> {
        return base.itemsCollectionView.nextPageTrigger.startWith(1)
    }
    var items: AnyObserver<MoviePage> {
        return base.itemsCollectionView.itemsResult
    }
}
