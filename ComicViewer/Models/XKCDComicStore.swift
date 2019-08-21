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
    guard let comic = currentComic else {
      return 0
    }

    return comic.index
  }
  
  var currentComic: Comic?

  func setUp(completionHandler: @escaping (Error?) -> Void) {
    comic(at: nil) { [weak self] comic, error in
      self?.currentComic = comic
      completionHandler(error)
    }
  }

  func comic(at index: Int?, completionHandler: @escaping (Comic?, Error?) -> Void) -> Void {
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
