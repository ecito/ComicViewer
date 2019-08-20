//
//  DataViewController.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/19/19.
//  Copyright © 2019 DML. All rights reserved.
//

import UIKit

class ComicDetailViewController: UIViewController {

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
    if dataLabel != nil && imageView != nil {
      if let viewModel = viewModel {
        dataLabel.text = viewModel.title
        if let URL = viewModel.URL {
          imageView.af_setImage(withURL: URL)
        }
      }
    }
  }
}

