//
//  DummyResponse.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Foundation

struct DummyResponse: Codable {
  var id: Int

  static var emptyData: Data {
    Data()
  }

  static var invalidData: Data {
    let jsonString = """
    {
        "dummy": "dummy",
    }
    """
    return Data(jsonString.utf8)
  }

  static var validData: Data {
    let jsonString = """
    {
        "code": 200,
        "message": "ログインしました",
        "data": {
            "id": 123
        }
    }
    """
    return Data(jsonString.utf8)
  }

  static var failureData: Data {
    let jsonString = """
    {
        "code": 500,
        "message": "ページがありません",
        "data": {}
    }
    """
    return Data(jsonString.utf8)
  }

  static var successData: Data {
    let jsonString = """
    {
        "code": 200,
        "message": "ログインしました",
        "data": {
            "id": 123
        }
    }
    """
    return Data(jsonString.utf8)
  }

  static var sample: DummyResponse {
    return DummyResponse(id: 123)
  }
}

extension DummyResponse: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.id == rhs.id
  }
}
