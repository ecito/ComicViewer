//
//  ComicCollectionViewCell.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import UIKit

class ComicCollectionViewCell: UICollectionViewCell {

  var viewModel: ComicViewModel? {
    didSet {
      if let viewModel = viewModel {
        if let URL = viewModel.URL {
          imageView.af_setImage(withURL: URL)
        }
      }
    }
  }

  @IBOutlet weak var imageView: UIImageView!
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func prepareForReuse() {
    imageView.image = nil
  }
}
