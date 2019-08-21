//
//  ComicViewModel.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation

class ComicViewModel {
  var title: String = ""
  var details: String = ""
  var url: URL?

  init?(comic: Comic) {
    self.title = comic.title
    self.details = comic.details
    if let url = URL(string: comic.imageURL) {
      self.url = url
    }
    else {
      return nil
    }
  }
}
