//
//  ComicStore.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation

/*
Generic comic store that could be backed by network, cache, coredata, etc
 */

protocol ComicStore {
  var numberOfComics: Int { get }
  var currentComic: Comic? { get }
  func setUp(completionHandler: @escaping (Error?) -> Void)

  func comic(at index: Int?, completionHandler: @escaping (Comic?, Error?) -> Void) -> Void
}
