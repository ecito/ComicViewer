//
//  ComicCollectionDataSource.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class ComicCollectionDataSource: NSObject, UICollectionViewDataSource {

  var comicStore: ComicStore

  init(comicStore: ComicStore) {
    self.comicStore = comicStore
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return comicStore.numberOfComics
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let index = self.comicStore.numberOfComics - indexPath.row
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ComicCollectionViewCell
    comicStore.comicAtIndex(at: index) { [weak self] comic, error in
      if error != nil {
        cell.backgroundColor = .red
      }
      else if let comic = comic {
        cell.viewModel = self?.viewModelFor(comic: comic)
      }
    }
    return cell
  }

  func viewModelFor(comic: Comic) -> ComicViewModel {
    let viewModel = ComicViewModel()
    viewModel.title = comic.title
    viewModel.details = comic.details
    if let url = URL(string: comic.imageURL) {
      viewModel.URL = url
    }

    return viewModel
  }
}
