//
//  RootViewController.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/19/19.
//  Copyright © 2019 DML. All rights reserved.
//

import UIKit

class ComicPageViewController: UIViewController, HasComicViewModel, HasComicStore {
  fileprivate var pageViewController: UIPageViewController?

  var viewModel: ComicViewModel?

  var comicStore: ComicStore = EmptyComicStore()

  override func viewDidLoad() {
    super.viewDidLoad()

    setupPageController()
  }

  fileprivate func showError() {
    self.view.backgroundColor = .red
  }

  fileprivate func setupPageController() {
    self.pageViewController = UIPageViewController(transitionStyle: Configuration.pageTransitionStyle(), navigationOrientation: .horizontal, options: nil)
    self.pageViewController!.delegate = self

    guard let startingIndex = viewModel?.index ?? comicStore.currentComic?.index else {
      return
    }

    let startingViewController: ComicPageDetailViewController = self.dataSource.viewControllerAtIndex(startingIndex, storyboard: self.storyboard!)!
    startingViewController.viewModel = viewModel

    let viewControllers = [startingViewController]
    self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })

    self.pageViewController!.dataSource = self.dataSource

    self.addChild(self.pageViewController!)
    self.view.addSubview(self.pageViewController!.view)

    self.pageViewController!.didMove(toParent: self)
  }

  fileprivate lazy var dataSource: PageViewDataSource = {
    let dataSource = PageViewDataSource(store: self.comicStore)
    return dataSource
  }()
}

// MARK: - UIPageViewController delegate methods
// xcode template code... 
extension ComicPageViewController: UIPageViewControllerDelegate {
  func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewController.SpineLocation {
    if (orientation == .portrait) || (orientation == .portraitUpsideDown) || (UIDevice.current.userInterfaceIdiom == .phone) {
        // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewController.SpineLocation.mid' in landscape orientation sets the doubleSided property to true, so set it to false here.
        let currentViewController = self.pageViewController!.viewControllers![0]
        let viewControllers = [currentViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })

        self.pageViewController!.isDoubleSided = false
        return .min
    }

    // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
    let currentViewController = self.pageViewController!.viewControllers![0] as! ComicPageDetailViewController
    var viewControllers: [UIViewController]

    let indexOfCurrentViewController = self.dataSource.indexOfViewController(currentViewController)
    if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
        let nextViewController = self.dataSource.pageViewController(self.pageViewController!, viewControllerAfter: currentViewController)
        viewControllers = [currentViewController, nextViewController!]
    } else {
        let previousViewController = self.dataSource.pageViewController(self.pageViewController!, viewControllerBefore: currentViewController)
        viewControllers = [previousViewController!, currentViewController]
    }
    self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })

    return .mid
  }
}

