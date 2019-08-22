//
//  MockComicStore.swift
//  ComicViewerTests
//
//  Created by Andre Navarro on 8/22/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation

@testable import ComicViewer

class MockComicStore: ComicStore {
  var availableIndexes: [Int] = [1]

  var numberOfComics: Int = 1

  lazy var currentComic: Comic? = {
    let comic = MockComic()
    comic.title = "Mock title"
    comic.details = "Mock details"
    comic.imageURL = "http://lolgoogle.com"
    comic.index = 1
    return comic
  }()

  func setUp(completionHandler: @escaping (Error?) -> Void) {
    completionHandler(nil)
  }

  func comic(at index: Int?, completionHandler: @escaping (Comic?, Error?) -> Void) {
    completionHandler(currentComic, nil)
  }
}
