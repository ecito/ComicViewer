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
    if let sanitizedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
      Alamofire.request(Router.xkcdRelevantSearch(sanitizedText)).validate().responseString(completionHandler: completionHandler)
    }
    else {
      let result = Result<String> { throw ComicError.someError("no text to search") }
      let response = DataResponse(request: nil, response: nil, data: nil, result: result)
      completionHandler(response)
    }
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
