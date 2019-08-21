//
//  ModelController.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/19/19.
//  Copyright © 2019 DML. All rights reserved.
//

import UIKit
import AlamofireImage

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class PageViewDataSource: NSObject, HasComicStore {

  var comicStore: ComicStore

  var currentPageIndex: Int = 0

  init(store: ComicStore) {
    comicStore = store
  }

  func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> ComicPageDetailViewController? {
    // Return the data view controller for the given index.
    guard comicStore.currentComic != nil,
      index <= comicStore.numberOfComics else {
        return nil
    }
//
//    if (self.comicStore.currentComic == nil) || (index > self.comicStore.numberOfComics) {
//        return nil
//    }

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
    // Return the index of the given data view controller.
    return viewController.comicIndex
  }
}

// MARK: - Page View Controller Data Source
extension PageViewDataSource: UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
      var index = self.indexOfViewController(viewController as! ComicPageDetailViewController)
      if (index == 1) || (index == NSNotFound) {
          return nil
      }
      
      index -= 1
      return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
  }

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
      var index = self.indexOfViewController(viewController as! ComicPageDetailViewController)
      if index == NSNotFound {
          return nil
      }
      
      index += 1
      if index == self.comicStore.numberOfComics + 1 {
          return nil
      }
      return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
  }
}

