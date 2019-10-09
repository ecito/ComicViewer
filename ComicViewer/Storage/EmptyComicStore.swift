//
//  EmptyComicStore.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation

class EmptyComicStore: ComicStore {
  var availableIndexes: [Int] = []

  var numberOfComics: Int = 0

  var currentComic: Comic?

  func setUp(completionHandler: @escaping (Result<Void, ComicError>) -> Void) {
  }

  func comic<T>(at index: Int?, completionHandler: @escaping (Result<T, ComicError>) -> Void) where T : Comic {
  }
}
