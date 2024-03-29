//
//  LoadingViewController.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController, HasComicStore {

  var comicStore: ComicStore = EmptyComicStore()

  override func viewDidLoad() {
    super.viewDidLoad()

    comicStore = DependencyInjector.dependency!.resolveStore()
    comicStore.setUp() { [weak self] result in
      switch result {
      case .success(_):
        self?.performSegue(withIdentifier: "PushComicCollection", sender: self)
      case .failure(_):
        self?.showError()
      }
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
