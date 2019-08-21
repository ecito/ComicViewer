//
//  StringValidation.swift
//  BBTest
//
//  Created by Andre Navarro on 8/15/19.
//  Copyright © 2019 DML. All rights reserved.
//

import Foundation

// https://www.hackingwithswift.com/example-code/strings/how-to-convert-a-string-to-a-safe-format-for-url-slugs-and-filenames

extension String {
  private static let slugSafeCharacters = CharacterSet(charactersIn: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-")

  public func convertedToSlug() -> String? {
    if let latin = self.applyingTransform(StringTransform("Any-Latin; Latin-ASCII; Lower;"), reverse: false) {
      let urlComponents = latin.components(separatedBy: String.slugSafeCharacters.inverted)
      let result = urlComponents.filter { $0 != "" }.joined(separator: "-")

      if result.count > 0 {
        return result
      }
    }

    return nil
  }
}
