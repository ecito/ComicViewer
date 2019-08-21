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

protocol HasComicViewModel: NSObject {
  var viewModel: ComicViewModel? { get set }
}

protocol HasComicStore: NSObject {
  var comicStore: ComicStore { get set }
}

class ComicCollectionViewController: UICollectionViewController, HasComicStore {

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
    performSegue(withIdentifier: "PushComicPage", sender: indexPath)
    //performSegue(withIdentifier: "PushComicDetail", sender: indexPath)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = sender as? IndexPath else {
      return
    }

    comicStore.comic(at: dataSource.comicIndex(for: indexPath)) { [weak self] comic, error in
      guard let comic = comic,
        let viewModel = ComicViewModel(comic: comic),
        error == nil else {
          // show error
          return
      }

      if let destination = segue.destination as? HasComicViewModel {
        destination.viewModel = viewModel
      }
      if let destination = segue.destination as? HasComicStore,
        let store = self?.comicStore {
        destination.comicStore = store
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
