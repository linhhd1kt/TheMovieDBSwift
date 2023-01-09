//
//  AlertController.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//
import UIKit

public final class AlertController: BaseViewController {
  @IBOutlet private var messageLabel: UILabel!

  public func set(_ message: String?) {
    messageLabel.text = message
  }
}
