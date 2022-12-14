//
//  UIView+Ex.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import UIKit

public extension UIView {
  var x: CGFloat {
    get {
      frame.origin.x
    }
    set {
      var frame = frame
      frame.origin.x = newValue
      self.frame = frame
    }
  }

  var y: CGFloat {
    get {
      frame.origin.y
    }

    set {
      var frame = frame
      frame.origin.y = newValue
      self.frame = frame
    }
  }

  var width: CGFloat {
    get {
      frame.size.width
    }

    set {
      var frame = frame
      frame.size.width = newValue
      self.frame = frame
    }
  }

  var height: CGFloat {
    get {
      frame.size.height
    }

    set {
      var frame = frame
      frame.size.height = newValue
      self.frame = frame
    }
  }

  var size: CGSize {
    get {
      frame.size
    }

    set {
      var frame = frame
      frame.size = newValue
      self.frame = frame
    }
  }

  var origin: CGPoint {
    get {
      frame.origin
    }

    set {
      var frame = frame
      frame.origin = newValue
      self.frame = frame
    }
  }

  var bottom: CGFloat {
    frame.origin.y + frame.size.height
  }

  var parentVC: UIViewController? {
    weak var parentResponder: UIResponder? = self
    while parentResponder != nil {
      // swiftlint:disable force_unwrapping
      parentResponder = parentResponder!.next
      if let viewController = parentResponder as? UIViewController {
        return viewController
      }
    }
    return nil
  }
}

public extension UIView {
  func attach(_ view: UIView) {
    view.translatesAutoresizingMaskIntoConstraints = false
    addSubview(view)
    NSLayoutConstraint.activate(
      [
        view.leadingAnchor.constraint(equalTo: leadingAnchor),
        view.trailingAnchor.constraint(equalTo: trailingAnchor),
        view.topAnchor.constraint(equalTo: topAnchor),
        view.bottomAnchor.constraint(equalTo: bottomAnchor)
      ]
    )
  }
}

public extension UIView {
  /// SwifterSwift: Border color of view; also inspectable from Storyboard.
  @IBInspectable var borderColor: UIColor? {
    get {
      guard let color = layer.borderColor else {
        return nil
      }
      return UIColor(cgColor: color)
    }
    set {
      guard let color = newValue else {
        layer.borderColor = nil
        return
      }
      // Fix React-Native conflict issue
      guard String(describing: type(of: color)) != "__NSCFType" else {
        return
      }
      layer.borderColor = color.cgColor
    }
  }

  /// SwifterSwift: Border width of view; also inspectable from Storyboard.
  @IBInspectable var borderWidth: CGFloat {
    get {
      layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }

  /// SwifterSwift: Corner radius of view; also inspectable from Storyboard.
  @IBInspectable var cornerRadius: CGFloat {
    get {
      layer.cornerRadius
    }
    set {
      layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
    }
  }

  @IBInspectable var shadowColor: UIColor? {
    get {
      guard let color = layer.shadowColor else {
        return nil
      }
      return UIColor(cgColor: color)
    }
    set {
      layer.shadowColor = newValue?.cgColor
    }
  }

  /// SwifterSwift: Shadow offset of view; also inspectable from Storyboard.
  @IBInspectable var shadowOffset: CGSize {
    get {
      layer.shadowOffset
    }
    set {
      layer.shadowOffset = newValue
    }
  }

  /// SwifterSwift: Shadow opacity of view; also inspectable from Storyboard.
  @IBInspectable var shadowOpacity: Float {
    get {
      layer.shadowOpacity
    }
    set {
      layer.shadowOpacity = newValue
    }
  }

  /// SwifterSwift: Shadow radius of view; also inspectable from Storyboard.
  @IBInspectable var shadowRadius: CGFloat {
    get {
      layer.shadowRadius
    }
    set {
      layer.shadowRadius = newValue
    }
  }

  func round(corners: UIRectCorner, radius: CGFloat) {
    let maskPath = UIBezierPath(
      roundedRect: bounds,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius)
    )

    let shape = CAShapeLayer()
    shape.path = maskPath.cgPath

    layer.mask = shape
  }
//
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        self.layer.mask = mask
//    }
//
//    let maskPath = UIBezierPath(
//                roundedRect: view.bounds,
//                byRoundingCorners: [.allCorners],
//                cornerRadii: CGSize(width: 10.0, height: 10.0)
//            )
//
//    let shape = CAShapeLayer()
//    shape.path = maskPath.cgPath
//
//    view.layer.mask = shape
}

public extension UIView {
  internal var parentViewController: UIViewController? {
    // Starts from next (As we know self is not a UIViewController).
    var parentResponder: UIResponder? = next
    while parentResponder != nil {
      if let viewController = parentResponder as? UIViewController {
        return viewController
      }
      parentResponder = parentResponder?.next
    }
    return nil
  }

  /// SwifterSwift: Shake directions of a view.
  ///
  /// - horizontal: Shake left and right.
  /// - vertical: Shake up and down.
  enum ShakeDirection {
    case horizontal
    case vertical
  }

  /// SwifterSwift: Shake animations types.
  ///
  /// - linear: linear animation.
  /// - easeIn: easeIn animation
  /// - easeOut: easeOut animation.
  /// - easeInOut: easeInOut animation.
  enum ShakeAnimationType {
    case linear
    case easeIn
    case easeOut
    case easeInOut
  }

  /// SwifterSwift: Angle units.
  ///
  /// - degrees: degrees.
  /// - radians: radians.
  enum AngleUnit {
    /// degrees.
    case degrees

    /// radians.
    case radians
  }

//    /// SwifterSwift: Shake view.
//    ///
//    /// - Parameters:
//    ///   - direction: shake direction (horizontal or vertical), (default is .horizontal)
//    ///   - duration: animation duration in seconds (default is 1 second).
//    ///   - animationType: shake animation type (default is .easeOut).
//    ///   - completion: optional completion handler to run with animation finishes (default is nil).
//    public func shake(direction: ShakeDirection = .horizontal,
//                      duration: TimeInterval = 1,
//                      animationType: ShakeAnimationType = .easeOut,
//                      completion:(() -> Void)? = nil) {
//        CATransaction.begin()
//        let animation: CAKeyframeAnimation
//        switch direction {
//        case .horizontal:
//            animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
//        case .vertical:
//            animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
//        }
//        switch animationType {
//        case .linear:
//            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
//        case .easeIn:
//            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
//        case .easeOut:
//            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
//        case .easeInOut:
//            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        }
//        CATransaction.setCompletionBlock(completion)
//        animation.duration = duration
//        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
//        layer.add(animation, forKey: "shake")
//        CATransaction.commit()
//    }

  /// SwifterSwift: Rotate view by angle on relative axis.
  ///
  /// - Parameters:
  ///   - angle: angle to rotate view by.
  ///   - type: type of the rotation angle.
  ///   - animated: set true to animate rotation (default is true).
  ///   - duration: animation duration in seconds (default is 1 second).
  ///   - completion: optional completion handler to run with animation finishes (default is nil).
  func rotate(byAngle angle: CGFloat, ofType type: AngleUnit, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
    let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
    let aDuration = animated ? duration : 0
    UIView.animate(withDuration: aDuration, delay: 0, options: .curveLinear, animations: { () in
      self.transform = self.transform.rotated(by: angleWithType)
    }, completion: completion)
  }

  /// SwifterSwift: Rotate view to angle on fixed axis.
  ///
  /// - Parameters:
  ///   - angle: angle to rotate view to.
  ///   - type: type of the rotation angle.
  ///   - animated: set true to animate rotation (default is false).
  ///   - duration: animation duration in seconds (default is 1 second).
  ///   - completion: optional completion handler to run with animation finishes (default is nil).
  func rotate(toAngle angle: CGFloat, ofType type: AngleUnit, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
    let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
    let aDuration = animated ? duration : 0
    UIView.animate(withDuration: aDuration, animations: {
      self.transform = self.transform.concatenating(CGAffineTransform(rotationAngle: angleWithType))
    }, completion: completion)
  }

  /// SwifterSwift: Scale view by offset.
  ///
  /// - Parameters:
  ///   - offset: scale offset
  ///   - animated: set true to animate scaling (default is false).
  ///   - duration: animation duration in seconds (default is 1 second).
  ///   - completion: optional completion handler to run with animation finishes (default is nil).
  func scale(by offset: CGPoint, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
    if animated {
      UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () in
        self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
      }, completion: completion)
    } else {
      transform = transform.scaledBy(x: offset.x, y: offset.y)
      completion?(true)
    }
  }

  internal func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }

  internal func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 1

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  internal func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}
