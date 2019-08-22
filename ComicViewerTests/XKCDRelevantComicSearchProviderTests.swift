//
//  XKCDRelevantComicSearchProviderTests.swift
//  ComicViewerTests
//
//  Created by Andre Navarro on 8/22/19.
//  Copyright © 2019 DML. All rights reserved.
//

import XCTest
@testable import ComicViewer

class XKCDRelevantComicSearchProviderTests: XCTestCase {

  var provider: XKCDRelevantComicSearchProvider!

  override func setUp() {
    DependencyInjector.dependency = MockDependency()

    provider = XKCDRelevantComicSearchProvider()
  }

  func testEmptyResult() {
    let expectation = XCTestExpectation(description: "should receive no results")

    provider.search(text: "fail") { result, error in
      if result == nil {
        expectation.fulfill()
      }
      else {
        expectation.isInverted = true
        expectation.fulfill()
      }
    }

    wait(for: [expectation], timeout: 2.0)
  }

  func testGotsResults() {
    let expectation = XCTestExpectation(description: "should receive some results")

    let expectedIndexes = [329, 632, 1213, 809, 901, 759, 583, 217, 269]

    provider.search(text: "test") { result, error in
      if let indexes = result?.indexes,
        indexes == expectedIndexes {
        expectation.fulfill()
      }
      else {
        expectation.isInverted = true
        expectation.fulfill()
      }
    }

    wait(for: [expectation], timeout: 2.0)
  }
}
