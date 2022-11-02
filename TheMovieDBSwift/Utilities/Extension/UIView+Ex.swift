//
//  UIView+Ex.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 02/11/2022.
//

import RxSwift
import UIKit

extension Reactive where Base: UIView {
    var loading: Binder<Bool> {
        return Binder(self.base) { base, loading in
            if loading {
                base.showActivityIndicator()
            } else {
                base.hideActivityIndicator()
            }
        }
    }
}

extension UIView {
    func showActivityIndicator() {
        let indicator = UIActivityIndicatorView()
        var y: CGFloat = 0
        
        if let scrollView = self as? UIScrollView {
            y = scrollView.contentSize.height - (scrollView.contentSize.height - scrollView.contentOffset.y) / 2
            indicator.frame = CGRect(x: 0, y: y, width: 50, height: 50)
            indicator.center = CGPoint(x: bounds.width / 2, y: y)
        } else {
            indicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            indicator.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        }
        
        indicator.style = .medium
        indicator.startAnimating()
        addSubview(indicator)
        bringSubviewToFront(indicator)
    }
    
    func hideActivityIndicator() {
        subviews
            .filter { $0.className == UIActivityIndicatorView.className }
            .forEach { $0.removeFromSuperview() }
    }
}
