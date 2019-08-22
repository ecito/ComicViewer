//
//  XKCDRelevantComicSearchProvider.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/21/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation

class XKCDRelevantComicSearchProvider: ComicSearchProvider {
  func searchResultFromResponse(response: String) -> XKCDComicSearchResult? {
    let array = response.components(separatedBy: CharacterSet.newlines)
    guard array.count > 2 else {
      return nil
    }

    // use relevance > 0 to know if we got valid results or not
    let relevance = array[safe: 0]?.trimmingCharacters(in: .whitespacesAndNewlines)

    guard relevance != "0.0" else {
      return nil
    }

    // grab the results from the 3rd line onwards
    let hits = Array(array[2...array.count - 1])

    let indexes = hits.compactMap { line -> Int? in
      // we just care about the number at the beggining of each line
      if let indexString = line.components(separatedBy: " ").first,
        let index = Int(indexString) {
        return index
      }
      else {
        return nil
      }
    }

    let result = XKCDComicSearchResult()
    result.indexes = indexes
    if let relevance = relevance {
      result.relevance = Double(relevance)
    }

    return result
  }

  func search(text: String, completionHandler: @escaping (ComicSearchResult?, Error?) -> Void) {
    let network = DependencyInjector.dependency!.resolveNetworkType()
    network.search(text: text) { [weak self] response in
      guard response.error == nil else {
        completionHandler(nil, response.error)
        return
      }

      guard let responseString = response.value else {
        completionHandler(nil, ComicError.someError("no response string"))
        return
      }

      guard let indexes = self?.searchResultFromResponse(response: responseString) else {
        completionHandler(nil, ComicError.someError("search result parsing error"))
        return
      }

      completionHandler(indexes, nil)
    }
  }
}
