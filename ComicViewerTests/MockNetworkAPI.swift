//
//  TestNetworkAPI.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/22/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation
import Alamofire

@testable import ComicViewer

class MockNetworkAPI: ComicNetworkAPI {
  static func currentComic<T>(completionHandler: @escaping (DataResponse<T>) -> Void) where T : Comic {
    MockNetworkAPI.comic(at: 0, completionHandler: completionHandler)
  }

  static func comic<T>(at index: Int?, completionHandler: @escaping (DataResponse<T>) -> Void) where T : Comic {
    if let path = Bundle(for: XKCDRelevantComicSearchProviderTests.self).path(forResource: (index != nil) ? "xkcd_614" : "xkcd_current", ofType: "json") {
      let result = Result<MockComic> {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return try JSONDecoder().decode(MockComic.self, from: data)
      }

      let response = DataResponse<MockComic>(request: nil, response: nil, data: nil, result: result)
      completionHandler(response as! DataResponse<T>)
    }
  }

  static func search(text: String, completionHandler: @escaping (DataResponse<String>) -> Void) {
    if let path = Bundle(for: XKCDRelevantComicSearchProviderTests.self).path(forResource: (text == "fail") ? "empty_search" : "search", ofType: "txt") {
      let result = Result<String> {
        try String(decoding: Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe), as: UTF8.self)
      }

      let response = DataResponse<String>(request: nil, response: nil, data: nil, result: result)
      completionHandler(response)
    }
  }
}
