//
//  Router.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
  case xkcdComic(_ index: UInt32?)

  var method: HTTPMethod {
    switch self {
    case .xkcdComic:
      return .get
    }
  }

  var url: String {
    switch self {
    case .xkcdComic(let index):
      if let index = index {
        return "https://xkcd.com/\(index)/info.0.json"
      }
      else {
        return "https://xkcd.com/info.0.json"
      }
    }
  }

  // MARK: URLRequestConvertible

  func asURLRequest() throws -> URLRequest {
    var urlRequest = URLRequest(url: try url.asURL())
    urlRequest.httpMethod = method.rawValue

    return urlRequest
  }
}
