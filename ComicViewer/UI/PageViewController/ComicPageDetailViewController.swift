//
//  DataViewController.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/19/19.
//  Copyright © 2019 DML. All rights reserved.
//

import UIKit

class ComicPageDetailViewController: UIViewController, ComicViewHasViewModel {

  @IBOutlet weak var dataLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!

  var comicIndex: Int = NSNotFound

  var viewModel: ComicViewModel? {
    didSet {
      render()
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    render()
  }

  func render() {
    guard dataLabel != nil && imageView != nil else {
      return
    }

    guard let viewModel = viewModel else {
      return
    }

    dataLabel.text = viewModel.title
    if let url = viewModel.url {
      imageView.af_setImage(withURL: url)
    }
  }
}

