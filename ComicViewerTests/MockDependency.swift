//
//  MockDependency.swift
//  ComicViewerTests
//
//  Created by Andre Navarro on 8/22/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation

@testable import ComicViewer

class MockDependency: Dependency {
  func resolveNetworkType() -> ComicNetworkAPI.Type {
    return MockNetworkAPI.self
  }

  func resolveStore() -> ComicStore {
    return MockComicStore()
  }

  func resolveSearchProvider() -> ComicSearchProvider {
    return MockSearchProvider()
  }
}
