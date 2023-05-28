//
//  RecipeItemView.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 24/05/2023.
//

import SwiftUI

// MARK: RecipeItemView
struct RecipeItemView: View {
    
    let namespace: Namespace.ID
    @Binding var isShowing: Bool
    @Binding var selectedModel: MealData?
    var data: MealData

    
    var body: some View {
        HStack {
            if let url = URL(string: data.imageUrl.unwrappedValue) {
                ImageViewer(source: url)
                    .matchedGeometryEffect(id: "image\(data.id.unwrappedValue)", in: namespace)
                    .frame(width: 125, height: 125)
            }
            VStack(spacing: 0) {
                Text(data.title.unwrappedValue)
                    .americanTypewriterTitleTextStyle()
                    .multilineTextAlignment(.leading)
                    .padding(5)
                    .lineLimit(3)
                
                Spacer()
                
                ZStack {
                    Button {
                        isShowing = true
                        selectedModel = data
                    } label: {
                        Text("View More")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 12))
                            .padding(10)
                            .foregroundColor(.black)
                            .overlay(
                                Capsule()
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding(10)
                    }
                    
                }
            }
            
        }
        .matchedGeometryEffect(id: "background\(data.id.unwrappedValue)" , in: namespace)
        .background(Rectangle().fill(Color.white))
        .cornerRadius(10)
        .shadow(color: .gray, radius: 3, x: 2, y: 2)
        .foregroundColor(.black)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        
    }
}
