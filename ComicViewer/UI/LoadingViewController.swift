//
//  LoadingViewController.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController, HasComicStore {

  var comicStore: ComicStore = DependencyInjector.dependency!.resolveStore()

  override func viewDidLoad() {
    super.viewDidLoad()

    comicStore.setUp() { [weak self] error in
      guard error == nil else {
        self?.showError()
        return
      }

      self?.performSegue(withIdentifier: "PushComicCollection", sender: self)
    }
  }

  func showError() {
    view.backgroundColor = .red
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destinationNav = segue.destination as? UINavigationController,
      let destination = destinationNav.viewControllers.first as? ComicCollectionViewController {
      destination.comicStore = comicStore
    }
  }
}
