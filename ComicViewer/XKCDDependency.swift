//
//  XKCDDependency.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/21/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation

class XKCDDependency: Dependency {
  func resolveNetworkType() -> ComicNetworkAPI.Type {
    return XKCDComicNetworkAPI.self
  }

  func resolveStore() -> ComicStore {
    return XKCDComicStore()
  }

  func resolveCache() {
    return
  }
}
