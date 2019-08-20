//
//  ComicCollectionViewController.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/20/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation
import UIKit
import MagazineLayout

class ComicCollectionViewController: UICollectionViewController {

  var comicStore: ComicStore = EmptyComicStore()
  
  lazy var dataSource: ComicCollectionDataSource = {
    return ComicCollectionDataSource(comicStore: self.comicStore)
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.collectionViewLayout = MagazineLayout()
    collectionView.register(ComicCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    collectionView.dataSource = self.dataSource
    collectionView.delegate = self
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    performSegue(withIdentifier: "PushComicDetail", sender: indexPath)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? ComicViewController,
      let indexPath = sender as? IndexPath {
      comicStore.comic(at: dataSource.comicIndex(for: indexPath)) { comic, error in
        if let comic = comic {
          let viewModel = ComicViewModel()
          viewModel.title = comic.title
          viewModel.details = comic.details
          if let url = URL(string: comic.imageURL) {
            viewModel.URL = url
          }

          destination.viewModel = viewModel
        }
      }
    }
  }
}

extension ComicCollectionViewController: UICollectionViewDelegateMagazineLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, visibilityModeForHeaderInSectionAtIndex index: Int) -> MagazineLayoutHeaderVisibilityMode {
    return .hidden
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, visibilityModeForFooterInSectionAtIndex index: Int) -> MagazineLayoutFooterVisibilityMode {
    return .hidden
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, visibilityModeForBackgroundInSectionAtIndex index: Int) -> MagazineLayoutBackgroundVisibilityMode {
    return .hidden
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeModeForItemAt indexPath: IndexPath)
    -> MagazineLayoutItemSizeMode
  {
    return MagazineLayoutItemSizeMode(widthMode: .halfWidth, heightMode: .dynamicAndStretchToTallestItemInRow)
//    return MagazineLayoutItemSizeMode(widthMode: .fullWidth(respectsHorizontalInsets: true), heightMode: .dynamicAndStretchToTallestItemInRow)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    horizontalSpacingForItemsInSectionAtIndex index: Int)
    -> CGFloat
  {
    return 12
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    verticalSpacingForElementsInSectionAtIndex index: Int)
    -> CGFloat
  {
    return 12
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetsForSectionAtIndex index: Int)
    -> UIEdgeInsets
  {
    return UIEdgeInsets(top: 24, left: 4, bottom: 24, right: 4)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetsForItemsInSectionAtIndex index: Int)
    -> UIEdgeInsets
  {
    return UIEdgeInsets(top: 24, left: 4, bottom: 24, right: 4)
  }

}
