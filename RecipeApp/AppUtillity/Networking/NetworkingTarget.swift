//
//  NetworkingTarget.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 24/05/2023.
//

import UIKit

public enum NetworkType: String, CaseIterable {
    case http, https
}

public enum HttpMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

public protocol NetworkTarget {
    var type: NetworkType { get }
    var base: String { get }
    var basePath: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var header: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: String]? { get }
    var sampleData: Data? { get }
}

extension NetworkTarget {
    public var type: NetworkType {
        return .https
    }

    public var base: String {
        return "themealdb.com"
    }
    
    public var basePath: String {
         return "/api/json/v1/1"
    }
}

