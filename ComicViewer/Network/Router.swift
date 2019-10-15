//
//  Router.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation
import NetworkKit

enum Router  {
  case xkcdComic(_ index: Int?)
  case xkcdRelevantSearch(_ text: String)

  var method: HTTPMethod {
    switch self {
    case .xkcdComic:
      return .get
    case .xkcdRelevantSearch(_):
      return .get
    }
  }

  var url: String {
    switch self {
    case .xkcdComic(let index):
      if let index = index {
        return "\(index)/info.0.json"
      }
      else {
        return "info.0.json"
      }
    case .xkcdRelevantSearch:
      return "process"
    }
  }
}
