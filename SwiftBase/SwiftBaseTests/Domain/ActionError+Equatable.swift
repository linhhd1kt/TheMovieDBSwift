//
//  ActionError+Equatable.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Action

extension ActionError: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.localizedDescription == rhs.localizedDescription
  }
}
