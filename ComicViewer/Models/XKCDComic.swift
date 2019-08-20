//
//  XKCDComic.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/19/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation

struct XKCDComic: Comic {
  let title: String
  let imageURL: String
  let details: String
  let index: Int

  enum CodingKeys: String, CodingKey {
    case imageURL = "img"
    case details = "alt"
    case index = "num"
    case title
  }
}
