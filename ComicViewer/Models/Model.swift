//
//  Model.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/19/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation

protocol Model: Codable {}

enum ComicError: Error {
  case someError(String)
}
