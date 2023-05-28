//
//  ImageViewer.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 24/05/2023.
//

import UIKit

actor ImageViewerManager {
    
    private let cache = ImageCache()
    
    public func view(by url: URL) async throws -> UIImage? {
        if let image = cache[url] {
            return image
        }
        let request = URLRequest(url: url)
        guard let image = try await view(by: request) else {
            return nil
        }
        self.cache[url] = image
        return image
    }
    
    public func view(by urlRequest: URLRequest) async throws -> UIImage? {
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return UIImage(data: data)
    }
    
    private enum LoaderStatus {
        case loading(Task<UIImage, Error>)
        case complete(UIImage)
    }
    
}

