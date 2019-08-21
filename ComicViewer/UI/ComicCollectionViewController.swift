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

  @IBOutlet var searchBar: UISearchBar!
  fileprivate lazy var searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    return searchController
  }()

  var comicStore: ComicStore = EmptyComicStore()

  lazy var dataSource: ComicCollectionDataSource = {
    return ComicCollectionDataSource(comicStore: self.comicStore)
  }()

  lazy var searchProvider: ComicSearchProvider = {
    return DependencyInjector.dependency!.resolveSearchProvider()
  }()

  var searchComicStore: ComicStore?

  override func viewDidLoad() {
    super.viewDidLoad()

    setupSearch()

    collectionView.collectionViewLayout = MagazineLayout()
    collectionView.register(ComicCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    collectionView.dataSource = self.dataSource
    collectionView.delegate = self
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    activeStore.comic(at: dataSource.comicIndex(for: indexPath)) { [weak self] comic, error in
      guard let comic = comic,
        let viewModel = ComicViewModel(comic: comic),
        error == nil else {
          // show error
          return
      }

      self?.performSegue(withIdentifier: "PushComicPage", sender: viewModel)
      //self?.performSegue(withIdentifier: "PushComicDetail", sender: indexPath)
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let viewModel = sender as? ComicViewModel else {
      return
    }

    if let destination = segue.destination as? HasComicStore {
      destination.comicStore = activeStore
    }
    if let destination = segue.destination as? HasComicViewModel {
      destination.viewModel = viewModel
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
    return MagazineLayoutItemSizeMode(widthMode: .halfWidth, heightMode: .dynamic)
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

extension ComicCollectionViewController {
  func setupSearch() {
    searchController.searchBar.delegate = self
    searchController.searchBar.scopeButtonTitles = ["Text", "Comic Number"]
  }

  var activeStore: ComicStore {
    get {
      return searchComicStore ?? comicStore
    }
  }

  func searchBarIsEmpty() -> Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }

  func isSearchingComicNumber() -> Bool {
    let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
  }

  func filterContentForSearchText(_ searchText: String, scope: String = "All") {
    if searchBarIsEmpty() {
      searchComicStore = nil
      dataSource.comicStore = comicStore
      collectionView.reloadData()
    }
    else {
      if isSearchingComicNumber(),
        let searchNumber = Int(searchText) {
        showComicNumber(index: searchNumber)
      }
      else {
        search(text: searchText)
      }
    }
  }

  func showComicNumber(index: Int) {
    var store = DependencyInjector.dependency!.resolveStore()
    store.availableIndexes = [index]

    searchComicStore = store
    dataSource.comicStore = store
    collectionView.reloadData()
  }

  func search(text: String) {
    searchProvider.search(text: text) { [weak self] result, error in
      guard let result = result,
        error == nil else {
          return
      }

      var store = DependencyInjector.dependency!.resolveStore()
      store.availableIndexes = result.indexes

      self?.searchComicStore = store
      self?.dataSource.comicStore = store
      self?.collectionView.reloadData()
    }
  }
}

extension ComicCollectionViewController: UISearchBarDelegate {
  // MARK: - UISearchBar Delegate
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    switch selectedScope {
    case 0:
      searchBar.keyboardType = .alphabet
    case 1:
      searchBar.keyboardType = .numberPad
    default:
      searchBar.keyboardType = .alphabet
    }
    searchBar.reloadInputViews()
    filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
  }
}

extension ComicCollectionViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
  }
}
