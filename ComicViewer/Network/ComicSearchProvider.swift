//
//  ComicSearchProvider.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/21/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation

protocol ComicSearchProvider {
  func search(text: String, completionHandler: @escaping (ComicSearchResult?, Error?) -> Void) -> Void
}
