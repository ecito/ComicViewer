//
//  TestNetworkAPI.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/22/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation
import NetworkKit

@testable import ComicViewer

class MockNetworkAPI: ComicNetworkAPI {
  static func currentComic<T>(completionHandler: @escaping (Result<T, ComicError>) -> Void) where T : Comic {
    MockNetworkAPI.comic(at: 0, completionHandler: completionHandler)
  }

  static func comic<T>(at index: Int?, completionHandler: @escaping (Result<T, ComicError>) -> Void) where T : Comic {
    if let path = Bundle(for: XKCDRelevantComicSearchProviderTests.self).path(forResource: (index != nil) ? "xkcd_614" : "xkcd_current", ofType: "json") {
      let result = Result<MockComic, Error> {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return try JSONDecoder().decode(MockComic.self, from: data)
      }

      let newResult = result.mapError { error in
        return ComicError.someError("asdf")
      }
      
      completionHandler(newResult as! Result<T, ComicError>)
    }
  }

  static func search(text: String, completionHandler: @escaping (Result<String, ComicError>) -> Void) {
    if let path = Bundle(for: XKCDRelevantComicSearchProviderTests.self).path(forResource: (text == "fail") ? "empty_search" : "search", ofType: "txt") {
      let result = Result<String, Error> {
        try String(decoding: Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe), as: UTF8.self)
      }

      let newResult = result.mapError { error in
        ComicError.someError("asdf")
      }
      
      completionHandler(newResult)
    }
  }
}
