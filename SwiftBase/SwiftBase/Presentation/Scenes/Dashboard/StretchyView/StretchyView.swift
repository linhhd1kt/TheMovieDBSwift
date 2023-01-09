//
//  StretchyView.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import UIKit

class StretchyView: UIView {
  @IBOutlet private var contentView: UIView!
  fileprivate let maxHeaderHeight: CGFloat = 360
  fileprivate let minHeaderHeight: CGFloat = 164
  fileprivate var previousScrollOffset: CGFloat = 0
  private var headerHeightContraint: NSLayoutConstraint?
  private var scrollView: UIScrollView?

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
  }

  func configure(_ heightConstraint: NSLayoutConstraint, scrollView: UIScrollView) {
    headerHeightContraint = heightConstraint
    self.scrollView = scrollView
    self.scrollView?.delegate = self
  }
}

extension StretchyView: UIScrollViewDelegate {
  func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
    guard let headerHeightContraint = headerHeightContraint else {
      fatalError("Header height constraint should not be nil!")
    }
    let scrollViewMaxHeight = scrollView.frame.height + headerHeightContraint.constant - minHeaderHeight
    return scrollView.contentSize.height > scrollViewMaxHeight
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard let headerHeightContraint = headerHeightContraint else {
      fatalError("Header height constraint should not be nil!")
    }
    let scrollDiff = (scrollView.contentOffset.y - previousScrollOffset)
    let isScrollingDown = scrollDiff > 0
    let isScrollingUp = scrollDiff < 0
    if canAnimateHeader(scrollView) {
      var newHeight = headerHeightContraint.constant
      if isScrollingDown {
        newHeight = max(minHeaderHeight, headerHeightContraint.constant - abs(scrollDiff))
      } else if isScrollingUp {
        newHeight = min(maxHeaderHeight, headerHeightContraint.constant + abs(scrollDiff))
      }
      if newHeight != headerHeightContraint.constant {
        headerHeightContraint.constant = newHeight
        setScrollPosition()
        previousScrollOffset = scrollView.contentOffset.y
      }
    }
  }

  func setScrollPosition() {
    scrollView?.contentOffset = CGPoint(x: 0, y: 0)
  }
}
