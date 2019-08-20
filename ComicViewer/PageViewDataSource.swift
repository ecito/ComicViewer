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


class PageViewDataSource: NSObject, UIPageViewControllerDataSource {

  var pageData: [String] = []

  var comicStore: ComicStore

  init(store: ComicStore) {
    comicStore = store
  }

  func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> ComicDetailViewController? {
    // Return the data view controller for the given index.
    if (self.comicStore.currentComic == nil) || (index > self.comicStore.numberOfComics) {
        return nil
    }

    // Create a new view controller and pass suitable data.
    let dataViewController = storyboard.instantiateViewController(withIdentifier: "DataViewController") as! ComicDetailViewController
    comicStore.comicAtIndex(at: index) { comic, error in
      if let comic = comic {
        dataViewController.comicIndex = comic.index
        dataViewController.dataLabel.text = comic.title

        if let url = URL(string: comic.imageURL) {
          dataViewController.imageView.af_setImage(withURL: url)
        }
      }
    }

    //dataViewController.dataObject = self.pageData[index]
    return dataViewController
  }

  func indexOfViewController(_ viewController: ComicDetailViewController) -> Int {
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return viewController.comicIndex
  }

  // MARK: - Page View Controller Data Source

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
      var index = self.indexOfViewController(viewController as! ComicDetailViewController)
      if (index == 0) || (index == NSNotFound) {
          return nil
      }
      
      index -= 1
      return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
  }

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
      var index = self.indexOfViewController(viewController as! ComicDetailViewController)
      if index == NSNotFound {
          return nil
      }
      
      index += 1
      if index == self.comicStore.numberOfComics {
          return nil
      }
      return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
  }

}

