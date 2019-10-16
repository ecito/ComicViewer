//
//  ComicCollectionDataSource.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation
import UIKit
import NetworkKit

class ComicCollectionDataSource: NSObject, UICollectionViewDataSource, HasComicStore {

  var comicStore: ComicStore

  init(comicStore: ComicStore) {
    self.comicStore = comicStore
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return comicStore.numberOfComics
  }

  func indexPathForComic(at index: Int) -> IndexPath {
    return IndexPath(item: comicStore.availableIndexes.firstIndex(of: index)!, section: 0)
  }

  func comicIndex(for indexPath: IndexPath) -> Int {
    return comicStore.availableIndexes[indexPath.row]
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ComicCollectionViewCell
      
    comicStore.comic(at: comicIndex(for: indexPath)) { [weak self] (result: Result<XKCDComic, ComicError>) in
      switch result {
      case .success(let comic):
        cell.backgroundColor = .white
        self?.comicStore.comicImage(for: comic) { (result: Result<UIImage, ComicError>) in
          if case let .success(image) = result {
            cell.imageView.image = image
          }
        }
      case .failure:
        cell.backgroundColor = .red

      }
    }

    return cell
  }
}
