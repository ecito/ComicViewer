//
//  ComicCollectionViewCell.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import UIKit
import MagazineLayout

class ScaledHeightImageView: UIImageView {

  override var intrinsicContentSize: CGSize {

    if let myImage = self.image {
      let myImageWidth = myImage.size.width
      let myImageHeight = myImage.size.height
      let myViewWidth = self.frame.size.width

      let ratio = myViewWidth/myImageWidth
      let scaledHeight = myImageHeight * ratio

      return CGSize(width: myViewWidth, height: scaledHeight)
    }
    return CGSize(width: -1.0, height: -1.0)
  }
}

class ComicCollectionViewCell: MagazineLayoutCollectionViewCell {

  let imageView: ScaledHeightImageView

  override init(frame: CGRect) {
    imageView = ScaledHeightImageView(frame: .zero)
    super.init(frame: frame)

    contentView.addSubview(imageView)

    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      ])
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
    imageView.af_cancelImageRequest()
  }
}
