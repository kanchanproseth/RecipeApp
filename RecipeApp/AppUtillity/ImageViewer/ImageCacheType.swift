//
//  ImageCacheType.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 25/05/2023.
//

import UIKit

public protocol ImageCacheType {
    func image(for url: URL) -> UIImage?
    func insertImage(_ image: UIImage?, for url: URL)
    func removeImage(for url: URL)
    func removeAllImages()
    subscript(_ url: URL) -> UIImage? { get set }
}
