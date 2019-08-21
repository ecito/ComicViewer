//
//  AppDelegate.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/19/19.
//  Copyright © 2019 DML. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    switch Configuration.comic() {
    case .xkcd:
      DependencyInjector.dependency = XKCDDependency()
    }

    return true
  }
}

