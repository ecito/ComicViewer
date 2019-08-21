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

    let relevance = array[safe: 0]?.trimmingCharacters(in: .whitespacesAndNewlines)

    guard relevance != "0.0" else {
      return nil
    }
    
    let hits = Array(array[2...array.count - 1])

    let indexes = hits.compactMap { line -> Int? in
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
    XKCDComicNetworkAPI.search(text: text) { [weak self] response in
      guard let responseString = response.value else {
        completionHandler(nil, nil)
        return
      }

      guard response.error == nil else {
        completionHandler(nil, response.error)
        return
      }

      guard let indexes = self?.searchResultFromResponse(response: responseString) else {
        completionHandler(nil, nil)
        return
      }

      completionHandler(indexes, nil)
    }
  }
}
