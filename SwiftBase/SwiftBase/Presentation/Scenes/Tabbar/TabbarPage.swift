//
//  TabbarPage.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

enum TabbarPage {
  case timecard
  case request
  case approve

  init?(index: Int) {
    switch index {
    case 0:
      self = .request
    case 1:
      self = .timecard
    case 2:
      self = .approve
    default:
      return nil
    }
  }

  func pageTitleValue() -> String {
    switch self {
    case .request:
      return "Request"
    case .timecard:
      return "TimeCard"
    case .approve:
      return "Approve"
    }
  }

  func pageOrderNumber() -> Int {
    switch self {
    case .request:
      return 0
    case .timecard:
      return 1
    case .approve:
      return 2
    }
  }

  // Add tab icon value

  // Add tab icon selected / deselected color

  // etc
}
