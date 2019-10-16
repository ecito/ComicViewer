//
//  DataViewController.swift
//  ComicViewer
//
//  Created by Andre Navarro on 8/19/19.
//  Copyright © 2019 DML. All rights reserved.
//

import UIKit

class ComicPageDetailViewController: UIViewController, HasComicViewModel {

  fileprivate var side: Side = .front

  @IBOutlet weak var dataLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var detailView: UIView!
  @IBOutlet weak var detailLabel: UILabel!

  var comicIndex: Int {
    guard let index = viewModel?.index else {
      return NSNotFound
    }
    return index
  }

  var viewModel: ComicViewModel? {
    didSet {
      render()
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    render()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    navigationController?.topViewController?.title = viewModel?.title
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    flip(to: .front, animated: false)
  }

  @IBAction func viewTapped(_ sender: Any) {
    flip()
  }

  fileprivate func render() {
    guard imageView != nil else {
      return
    }

    guard let viewModel = viewModel else {
      return
    }

    detailLabel.text = viewModel.details
    
    DependencyInjector.dependency?.resolveNetworkType().comicImage(for: viewModel.url.absoluteString, completionHandler: { [weak self] (result: Result<UIImage, ComicError>) in
      if case let .success(image) = result {
        self?.imageView.image = image
      }
    })
  }
}

// view flipping
extension ComicPageDetailViewController {
  enum Side {
    case front
    case back
  }

  fileprivate func flip() {
    flip(to: side == .front ? .back : .front, animated: true)
  }

  fileprivate func flip(to side: Side, animated: Bool) {
    let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]

    guard let toView = (side == .front) ? imageView : detailView else {
      return
    }
    guard let fromView = (side == .front) ? detailView : imageView else {
      return
    }

    UIView.transition(from: fromView, to: toView, duration: animated ? 0.3 : 0, options: transitionOptions, completion: nil)
    self.side = side
  }
}
