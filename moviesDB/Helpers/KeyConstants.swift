//
//  KeyConstants.swift
//  moviesDB
//
//  Created by Alan Rodriguez on 08/12/24.
//

import Foundation

enum KeyConstants {
  static func loadAPIKeys() async throws  {
    let request = NSBundleResourceRequest(tags: ["APIKeys"])
    try await request.beginAccessingResources()

    let url = Bundle.main.url(forResource: "APIKeys", withExtension: "json")!
    let data = try Data(contentsOf: url)
    APIKeys.storage = try JSONDecoder().decode([String: String].self, from: data)

    request.endAccessingResources()
  }

  enum APIKeys {
    static fileprivate(set) var storage = [String: String]()

    static var token: String { storage["token"] ?? "" }
  }
}
