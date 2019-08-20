//
//  ComicCollectionViewController.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation
import UIKit

class ComicCollectionViewController: UICollectionViewController {

  var comicStore: ComicStore = EmptyComicStore()
  
  lazy var dataSource: ComicCollectionDataSource = {
    return ComicCollectionDataSource(comicStore: self.comicStore)
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.dataSource = self.dataSource
    collectionView.reloadData()
  }
}
