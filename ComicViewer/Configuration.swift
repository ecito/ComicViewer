//
//  Configuration.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/21/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation
import UIKit

class Configuration {
  enum Comic {
    case xkcd
  }

  static func comic() -> Comic {
    return .xkcd
  }

  static func pageTransitionStyle() -> UIPageViewController.TransitionStyle {
    return .scroll
  }
}
