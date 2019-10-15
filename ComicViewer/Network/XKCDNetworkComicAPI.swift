//
//  XKCDComicNetworkAPI.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation
import NetworkKit

class XKCDComicNetworkAPI: ComicNetworkAPI {
  
  public static let webService = Webservice(baseURL: URL(string: "https://xkcd.com/")!)
  public static let searchWebService = Webservice(baseURL: URL(string: "https://relevantxkcd.appspot.com/")!)

  static func search(text: String, completionHandler: @escaping (Result<String, ComicError>) -> Void) {
    if let sanitizedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
      let parameters = ["action": "xkcd",
                        "query": sanitizedText]
      
      searchWebService.requestData(withPath: "process", method: .get, queryParameters: parameters) { (request, response, result: Result<Data, NetworkStackError>) in
        guard let string = String(data: try! result.get(), encoding: .utf8) else {
          completionHandler(.failure(.someError("some error")))
          return 
        }
        
        let stringResult = result.map { data in
          string
        }.mapError { error in
          ComicError.someError("Some error")
        }
        completionHandler(stringResult)
      }
    }
    else {
      let result = Result<String, ComicError>.failure(ComicError.someError("no text to search"))
      completionHandler(result)
    }
  }

  static func currentComic<T>(completionHandler: @escaping (Result<T, ComicError>) -> Void) where T : Comic {
    comic(at: nil, completionHandler: completionHandler)
  }

  static func comic<T>(at index: Int?, completionHandler: @escaping (Result<T, ComicError>) -> Void) where T : Comic {
  
    webService.request(withPath:Router.xkcdComic(index).url, method: Router.xkcdComic(index).method) { (response: Response<XKCDComic, NetworkStackError>) in

      let newResult = response.result.mapError { error in
        return ComicError.someError("asdf")
      }
      
      completionHandler(newResult as! Result<T, ComicError>)
    }
  }
}
