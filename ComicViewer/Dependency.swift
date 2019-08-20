//
//  Dependency.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation

protocol Dependency {
}

struct DependencyInjector {
  static var dependencies: Dependency?
}
