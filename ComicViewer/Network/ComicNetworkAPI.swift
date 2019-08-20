//
//  ComicNetworkAPI.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation
import Alamofire

protocol ComicNetworkAPI {
  static func currentComic<T: Comic>(completionHandler: @escaping (DataResponse<T>) -> Void) -> Void
  static func comic<T: Comic>(at index: Int?, completionHandler: @escaping (DataResponse<T>) -> Void) -> Void
}
