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
    XKCDComicNetworkAPI.currentComic { (response: DataResponse<XKCDComic>) in
      guard response.error == nil else {
        completionHandler(response.error)
        return
      }

      guard let comic = response.value else {
        print("no comic?")
        return
      }

      self.currentComic = comic
      completionHandler(nil)
    }
  }

  func comicAtIndex(at index: Int?, completionHandler: @escaping (Comic?, Error?) -> Void) -> Void {
    XKCDComicNetworkAPI.comic(at: index) { (response: DataResponse<XKCDComic>) in
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
