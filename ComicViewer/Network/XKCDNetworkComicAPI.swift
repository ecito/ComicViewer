//
//  XKCDComicNetworkAPI.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation
import Alamofire

class XKCDComicNetworkAPI: ComicNetworkAPI {
  static func search(text: String, completionHandler: @escaping (DataResponse<String>) -> Void) {
    Alamofire.request(Router.xkcdRelevantSearch(text)).validate().responseString(completionHandler: completionHandler)
  }

  static func currentComic<T>(completionHandler: @escaping (DataResponse<T>) -> Void) where T : Comic {
    comic(at: nil, completionHandler: completionHandler)
  }

  static func comic<T>(at index: Int?, completionHandler: @escaping (DataResponse<T>) -> Void) where T : Comic {
    Alamofire.request(Router.xkcdComic(index)).validate().responseData { response in
      let comic = response.flatMap { data in
        try JSONDecoder().decode(T.self, from: data)
      }

      completionHandler(comic)
    }
  }
}
