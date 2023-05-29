//
//  NetworkingManager.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 24/05/2023.
//

import Foundation

public protocol Networking {
    func make<T: Decodable>(target: NetworkTarget, model: T.Type) async -> Result<T, NetworkingError>
    func parseUrl(_ target: NetworkTarget) -> URL?
}

public struct NetworkingManager: Networking {
    
    public init() {}
    
    public func parseUrl(_ target: NetworkTarget) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = target.type.rawValue
        urlComponents.host = target.base
        urlComponents.path = target.basePath + target.path
        urlComponents.queryItems = target.queryItems
        
        return urlComponents.url
    }
    
    public func make<T: Decodable>(target: NetworkTarget, model: T.Type) async -> Result<T, NetworkingError> {
        // for mocking purpose load sample data from json file
        if let data = target.sampleData {
            return decode(data, model: model)
        }
        
        guard let url = parseUrl(target) else { return .failure(.invalidUrl)}
        
        let request = buildUrlRequest(with: target, from: url)
        
        return await handlingRequest(request, model: model)
    }
    
    private func decode<T: Decodable>(_ data: Data, model: T.Type) -> Result<T, NetworkingError> {
        guard let decodedResponse = try? JSONDecoder().decode(model, from: data) else {
            return .failure(.failedSerialization)
        }
        return .success(decodedResponse)
    }
    
    private func buildUrlRequest(with target: NetworkTarget, from url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = target.header
        
        if let body = target.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        return request
    }
    
    private func handlingRequest<T: Decodable>(_ request: URLRequest, model: T.Type) async -> Result<T, NetworkingError> {
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.invalidData)
            }
            
            switch response.statusCode {
            case 200...299:
                return decode(data, model: model)
            case 401:
                return .failure(.requestFailed(description: "unauthorized"))
            default:
                return .failure(.responseUnsuccessful(description: "unexpectedStatusCode"))
            }
        } catch {
            return .failure(.unknown)
        }
    }
}

