//
//  ComicStore.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation

protocol ComicStore {
  var numberOfComics: Int { get }
  var currentComic: Comic? { get }
  func setUp(completionHandler: @escaping (Error?) -> Void)

  func comicAtIndex(at index: Int?, completionHandler: @escaping (Comic?, Error?) -> Void) -> Void
}
