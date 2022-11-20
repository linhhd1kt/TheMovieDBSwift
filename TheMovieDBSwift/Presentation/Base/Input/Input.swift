//
//  Button.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 17/11/2022.
//

import UIKit
import RxSwift
import RxDataSources

class Input: UIView {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var textField: UITextField!
    
    // MARK: - Input
    fileprivate let inputTextObserver = PublishSubject<String?>()
    // MARK: - Output
    fileprivate let outputTextObserver = PublishSubject<String?>()
    
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
    }

    private func binding() {
        inputTextObserver
            .bind(to: textField.rx.text)
            .disposed(by: disposeBag)
        textField.rx.text.asObservable()
            .bind(to: outputTextObserver)
            .disposed(by: disposeBag)
    }
}

extension Input: HasDisposeBag {}

extension Reactive where Base: Input {
    var inputText: AnyObserver<String?> {
        return base.inputTextObserver.asObserver()
    }
    var outputText: Observable<String?> {
        return base.outputTextObserver.asObservable()
    }
}
