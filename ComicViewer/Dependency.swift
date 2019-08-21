//
//  Dependency.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation

protocol Dependency {
  func resolveNetworkType() -> ComicNetworkAPI.Type
  func resolveStore() -> ComicStore
  func resolveSearchProvider() -> ComicSearchProvider
}

struct DependencyInjector {
  static var dependency: Dependency?
}
