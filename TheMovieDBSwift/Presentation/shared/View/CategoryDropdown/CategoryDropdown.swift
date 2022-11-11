//
//  CategoryDropdown.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 30/10/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CategoryDropdown: UIView {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var selectedItemLabel: UILabel!
    @IBOutlet private weak var selectedItemButton: UIButton!
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private let categoryListObserver = BehaviorSubject<[PopularCategory]>(value: PopularCategory.allCases)
    private let selectedCategoryObserver = BehaviorSubject<PopularCategory>(value: PopularCategory.streaming)
    private let displayObserver = PublishSubject<Bool>()

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
    
    private func configureLayouts() {
        tableView.register(CategoryDropdownCell.self)
        tableView.register(SelectedCategoryDropdownCell.self)
        tableView.rowHeight = 32
        tableView.backgroundColor = R.color.secondary()
        tableView.cornerRadius = 16
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    
    private func binding() {
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
        Observable
            .combineLatest(categoryListObserver.asObservable(),
                           displayObserver.asObservable(),
                           selectedCategoryObserver.asObservable())
            .map({ items, display, selectedItem in
                if display {
                    return [selectedItem] + items.filter { $0.title != selectedItem.title }
                } else {
                    return [selectedItem]
                }
            })
            .map { [CategorySession(header: "Popular Categories", items: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        tableView.rx.modelSelected(PopularCategory.self)
            .bind(to: selectedCategoryObserver)
            .disposed(by: disposeBag)
        Observable.merge(selectedItemButton.rx.tap.asObservable(),
                         selectedCategoryObserver.map { _ in return })
            .scan(true) { lastState, _ in !lastState }
            .bind(to: displayObserver)
            .disposed(by: disposeBag)
        displayObserver.withUnretained(self)
            .subscribe { this, display in
                if let topView = self.parentVC?.view, let localView = self.superview {
                    if display {
                        let frame = topView.convert(self.frame, from: localView)
                        let fullHeight = this.tableView.rowHeight * CGFloat(PopularCategory.allCases.count)
                        let fullSize = CGSize(width: frame.width, height: fullHeight)
                        this.tableView.frame = CGRect(origin: frame.origin, size: fullSize)
                        topView.addSubview(this.tableView)
                    } else {
                        this.tableView.removeFromSuperview()
                    }
                }
            }
            .disposed(by: disposeBag)
        selectedCategoryObserver
            .map(\.title)
            .bind(to: selectedItemLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

extension CategoryDropdown: CategoryDropdownInput {
    var categoryList: AnyObserver<[PopularCategory]> {
        return categoryListObserver.asObserver()
    }
}

extension CategoryDropdown: CategoryDropdownOutput {
    var selectedPopularCategory: Observable<PopularCategory> {
        return selectedCategoryObserver.asObservable()
    }
}

extension CategoryDropdown: HasDisposeBag { }
