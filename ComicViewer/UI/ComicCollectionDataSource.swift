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

  func indexPathForComic(at index: Int) -> IndexPath {
    return IndexPath(item: self.comicStore.numberOfComics - index, section: 0)
  }

  func comicIndex(for indexPath: IndexPath) -> Int {
    return self.comicStore.numberOfComics - indexPath.row
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ComicCollectionViewCell
    comicStore.comic(at: comicIndex(for: indexPath)) { comic, error in
      if error != nil {
        cell.backgroundColor = .red
      }
      else if let comic = comic {
        cell.backgroundColor = .white

        if let URL = URL(string: comic.imageURL) {
          cell.imageView.af_setImage(withURL: URL, placeholderImage: UIImage(named: "loading")) { response in
            //collectionView.collectionViewLayout.invalidateLayout()
          }
        }
      }
    }

    return cell
  }
}
