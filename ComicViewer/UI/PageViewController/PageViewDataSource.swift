//
//  ModelController.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/19/19.
//  Copyright © 2019 DML. All rights reserved.
//

import UIKit
import AlamofireImage


class PageViewDataSource: NSObject, HasComicStore {

  var comicStore: ComicStore

  var currentPageIndex: Int = 0

  init(store: ComicStore) {
    comicStore = store
  }

  func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> ComicPageDetailViewController? {
    guard comicStore.availableIndexes.contains(index) else {
      return nil
    }

    // Create a new view controller and pass suitable data.
    let dataViewController = storyboard.instantiateViewController(withIdentifier: "DataViewController") as! ComicPageDetailViewController
    comicStore.comic(at: index) { comic, error in
      guard let comic = comic,
      let viewModel = ComicViewModel(comic: comic),
      error == nil else {
        return
      }

      dataViewController.viewModel = viewModel
    }

    return dataViewController
  }

  func indexOfViewController(_ viewController: ComicPageDetailViewController) -> Int {
    return viewController.comicIndex
  }
}

// MARK: - Page View Controller Data Source
extension PageViewDataSource: UIPageViewControllerDataSource {
  func indexBefore(index: Int) -> Int? {
    guard let indexOfIndex = comicStore.availableIndexes.firstIndex(of: index) else {
      return nil
    }

    return comicStore.availableIndexes[safe: indexOfIndex - 1]
  }

  func indexAfter(index:Int) -> Int? {
    guard let indexOfIndex = comicStore.availableIndexes.firstIndex(of: index) else {
      return nil
    }

    return comicStore.availableIndexes[safe: indexOfIndex + 1]
  }

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    let index = self.indexOfViewController(viewController as! ComicPageDetailViewController)

    guard let previousIndex = indexBefore(index: index) else {
      return nil
    }

    return self.viewControllerAtIndex(previousIndex, storyboard: viewController.storyboard!)
  }

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    let index = self.indexOfViewController(viewController as! ComicPageDetailViewController)

    guard let nextIndex = indexAfter(index: index) else {
      return nil
    }

    return self.viewControllerAtIndex(nextIndex, storyboard: viewController.storyboard!)
  }
}
