//
//  File.swift
//
//
//  Created by Guilherme Souza on 23/04/21.
//

import Foundation

internal struct Route {
  let path: String
  let method: Method
  let query: [URLQueryItem]?

  enum Method: String {
    case get = "GET"
  }
}

extension Route {
  func urlRequest(withBaseURL baseURL: URL) -> URLRequest {
    var url = baseURL.appendingPathComponent(path)
    var components = URLComponents(url: url, resolvingAgainstBaseURL: false)

    if let query = query {
      let currentQuery = components?.queryItems ?? []
      components?.queryItems = currentQuery + query
    }

    if let finalURL = components?.url {
      url = finalURL
    }

    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    return request
  }
}

extension Route {
  static func shows(_ page: Int) -> Route {
    Route(path: "/shows", method: .get, query: [URLQueryItem(name: "page", value: "\(page)")])
  }

  static func searchShows(_ term: String) -> Route {
    Route(
      path: "/search/shows",
      method: .get,
      query: [
        URLQueryItem(name: "q", value: term)
      ]
    )
  }
}