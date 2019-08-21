//
//  ComicViewController.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import UIKit

class ComicViewController: UIViewController, ComicViewHasViewModel {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var detailLabel: UILabel!

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
    guard titleLabel != nil,
      imageView != nil else {
        return
    }

    guard let viewModel = viewModel else {
      return
    }

    titleLabel.text = viewModel.title
    detailLabel.text = viewModel.details
    if let url = viewModel.url {
      imageView.af_setImage(withURL: url)
    }
  }
}
