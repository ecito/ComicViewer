//
//  MockComicStore.swift
//  ComicViewerTests
//
//  Created by Andre Navarro on 8/22/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation
import NetworkKit

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

  func setUp(completionHandler: @escaping (Result<Void, ComicError>) -> Void) {
    completionHandler(.success(()))
  }

  func comic<T>(at index: Int?, completionHandler: @escaping (Result<T, ComicError>) -> Void) where T : Comic {
    //completionHandler(Result<MockComic, ComicError>.success(currentComic! as! MockComic))
  }
}
