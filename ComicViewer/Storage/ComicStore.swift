//
//  ComicStore.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation
import UIKit

/*
Generic comic store that could be backed by network, cache, coredata, etc
 */

protocol ComicStore {
  var availableIndexes: [Int] { get set }
  var numberOfComics: Int { get }
  var currentComic: Comic? { get }

  func setUp(completionHandler: @escaping (Result<Void, ComicError>) -> Void) -> Void

  func comic<T>(at index: Int?, completionHandler: @escaping (Result<T, ComicError>) -> Void) -> Void where T : Comic
    
  func comicImage(for comic: Comic, completionHandler: @escaping (Result<UIImage, ComicError>) -> Void) -> Void
}
