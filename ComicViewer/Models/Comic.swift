//
//  Comic.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/19/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation

protocol Comic: Model {
  var title: String { get }
  var imageURL: String { get }
  var details: String { get }
  var index: Int { get }
}
