//
//  ComicSearchResult.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/21/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation

protocol ComicSearchResult {
  var relevance: Double? { get }
  var indexes: [Int] { get }
}
