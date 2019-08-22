//
//  MockSearchProvider.swift
//  ComicViewerTests
//
//  Created by Andre Navarro on 8/22/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation

@testable import ComicViewer

class MockSearchProvider: ComicSearchProvider {
  func search(text: String, completionHandler: @escaping (ComicSearchResult?, Error?) -> Void) {
    completionHandler(nil, nil)
  }
}
