//
//  ComicNetworkAPI.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation
import NetworkKit

protocol ComicNetworkAPI {
  static func currentComic<T: Comic>(completionHandler: @escaping (Result<T, ComicError>) -> Void) -> Void
  static func comic<T: Comic>(at index: Int?, completionHandler: @escaping (Result<T, ComicError>) -> Void) -> Void

  static func search(text: String, completionHandler: @escaping (Result<String, ComicError>) -> Void) -> Void
}
