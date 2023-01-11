//
//  UICollectionView+Ex.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import UIKit

public extension UICollectionView {
  func register<T: UICollectionViewCell>(_ type: T.Type, bundle: Bundle? = nil) {
    let className = type.className
    let nib = UINib(nibName: className, bundle: bundle)
    register(nib, forCellWithReuseIdentifier: className)
  }

  func register<T: UICollectionReusableView>(_ type: T.Type, ofKind kind: String = UICollectionView.elementKindSectionHeader, bundle: Bundle? = nil) {
    let className = type.className
    let nib = UINib(nibName: className, bundle: bundle)
    register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
  }

  ///
  /// using this function when register cell from pod
  ///
  func registerFromPod<T: UICollectionViewCell>(_ type: T.Type, from controller: UIViewController) {
    let podBundle = Bundle(for: T.classForCoder())
    guard let bundleURL = podBundle.url(forResource: controller.moduleName, withExtension: "bundle") else {
      fatalError("Cound not get bundle url from Domain!")
    }
    guard let bundle = Bundle(url: bundleURL) else {
      fatalError("Could not initial bundle from \(bundleURL)")
    }
    let nib = UINib(nibName: type.className, bundle: bundle)
    guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
      fatalError("Could not load view from bundle \(bundle.className)")
    }
    register(nib, forCellWithReuseIdentifier: T.className)
  }

  func dequeue<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as? T else {
      fatalError("Cast to \(type.className) failed")
    }
    return cell
  }

  func dequeue<T: UICollectionReusableView>(_ type: T.Type, for indexPath: IndexPath, ofKind kind: String = UICollectionView.elementKindSectionHeader) -> T {
    guard let section = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.className, for: indexPath) as? T else {
      fatalError("Cast to \(type.className) failed")
    }
    return section
  }
}
