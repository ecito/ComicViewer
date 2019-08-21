//
//  XKCDComicStore.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation
import Alamofire

class XKCDComicStore: ComicStore {
  var numberOfComics: Int {
    return availableIndexes.count
  }

  var availableIndexes: [Int] = []

  var currentComic: Comic?

  func setUp(completionHandler: @escaping (Error?) -> Void) {
    comic(at: nil) { [weak self] comic, error in
      self?.currentComic = comic
      if let comic = comic,
        comic.index > 1 {
        self?.availableIndexes = Array(1...comic.index)
      }
      completionHandler(error)
    }
  }

  func comic(at index: Int?, completionHandler: @escaping (Comic?, Error?) -> Void) -> Void {
    if let index = index,
      !availableIndexes.contains(index) {
      fatalError("you done messed up, any index passed in here should be in availableIndexes")
    }

    DependencyInjector.dependency?.resolveNetworkType().comic(at: index) { (response: DataResponse<XKCDComic>) in
      guard response.error == nil else {
        completionHandler(nil, response.error)
        return
      }

      guard let comic = response.value else {
        completionHandler(nil, nil)
        print("no comic? waaa")
        return
      }

      completionHandler(comic, nil)
    }
  }
}
