//
//  ImageViewKey.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 24/05/2023.
//

import SwiftUI

struct ImageViewerKey: EnvironmentKey {
    static let defaultValue = ImageViewerManager()
}

extension EnvironmentValues {
    var imageViewer: ImageViewerManager {
        get { self[ImageViewerKey.self] }
        set { self[ImageViewerKey.self ] = newValue}
    }
}
