//
//  XKCDComicStore.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation
import UIKit

class XKCDComicStore: ComicStore {
  func comicImage(for comic: Comic, completionHandler: @escaping (Result<UIImage, ComicError>) -> Void) {
    DependencyInjector.dependency?.resolveNetworkType().comicImage(for: comic.imageURL, completionHandler: completionHandler)
  }
  
  
  var numberOfComics: Int {
    return availableIndexes.count
  }

  var availableIndexes: [Int] = []

  var currentComic: Comic?

  func setUp(completionHandler: @escaping (Result<Void, ComicError>) -> Void) {
    comic(at: nil) { [weak self] (result: Result<XKCDComic, ComicError>) in
      switch result {
      case .success(let comic):
        self?.currentComic = comic
        if comic.index > 1 {
          self?.availableIndexes = Array(1...comic.index).reversed()
        }
        completionHandler(.success(()))
      case .failure(let error):
        completionHandler(.failure(error))
      
      }
    }
  }

  func comic<T>(at index: Int?, completionHandler: @escaping (Result<T, ComicError>) -> Void) -> Void where T : Comic {
    if let index = index,
      !availableIndexes.contains(index) {
      fatalError("you done messed up, any index passed in here should be in availableIndexes")
    }

    DependencyInjector.dependency?.resolveNetworkType().comic(at: index, completionHandler: completionHandler)
  }
}
