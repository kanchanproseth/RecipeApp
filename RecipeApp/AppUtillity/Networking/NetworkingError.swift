//
//  NetworkingError.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 24/05/2023.
//

import Foundation

public enum NetworkingError: Error {
    
    case requestFailed(description: String)
    case jsonConversionFailure(description: String)
    case invalidUrl
    case invalidData
    case responseUnsuccessful(description: String)
    case jsonParsingFailure
    case noInternet
    case failedSerialization
    case unknown
    
    var customDescription: String {
        switch self {
        case let .requestFailed(description): return "Request Failed error -> \(description)"
        case .invalidUrl: return "Invalid Url error"
        case .invalidData: return "Invalid Data error"
        case let .responseUnsuccessful(description): return "Response Unsuccessful error -> \(description)"
        case .jsonParsingFailure: return "JSON Parsing Failure error)"
        case let .jsonConversionFailure(description): return "JSON Conversion Failure -> \(description)"
        case .noInternet: return "No internet connection"
        case .failedSerialization: return "serialization print for debug failed."
        case .unknown: return "Unknown error"
        }
    }
}
