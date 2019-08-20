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
  var currentComicIndex: Int { get }
}
