//
//  ImageViewer.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 25/05/2023.
//

import SwiftUI

struct ImageViewer: View {
    private let source: URL
    @State private var image: UIImage?
    
    @Environment(\.imageViewer) private var imageViewer
    
    init(source: URL) {
        self.source = source
    }
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Rectangle()
                    .background(.gray)
            }
        }
        .task {
            image = await loadImage(at: source)
        }
    }
    
    func loadImage(at url: URL) async -> UIImage? {
        do {
            let image = try await imageViewer.view(by: url)
            return image
        } catch {
            print(error)
            return nil
        }
    }
    
}
