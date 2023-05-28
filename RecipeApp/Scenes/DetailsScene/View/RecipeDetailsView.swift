//
//  RecipeDetailsView.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 25/05/2023.
//

import SwiftUI

// MARK: RecipeDetailsView
struct RecipeDetailsView: View {
    
    @StateObject private var viewModel = RecipeDetailsViewModel()
    @Environment(\.presentationMode) private  var presentationMode
    @Binding var isShowing: Bool
    let namespace: Namespace.ID
    var id: String
    var title: String

    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Spacer(minLength: 70)
                if let url = URL(string: viewModel.imageUrl.unwrappedValue) {
                    ImageViewer(source: url)
                    .matchedGeometryEffect(id: "image\(id)", in: namespace)
                    .cornerRadius(10)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 10, x: 0, y: 2))
                    .frame(height: 150)
                    .padding(25)
                }
                    
                
                Spacer(minLength: 70)
                
                Text("Instructions")
                    .americanTypewriterTitleTextStyle2()
                    .padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 50))
                Text(viewModel.instructions.unwrappedValue)
                    .americanTypewriterContentTextStyle()
                    .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
                
                Text("Ingredients and measures")
                    .americanTypewriterTitleTextStyle2()
                    .padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 50))
                
                LazyVStack(alignment: .leading, spacing: 10) {
                    
                    ForEach(viewModel.ingredients.unwrappedValue) { item in
                        Text(" • ")
                            .americanTypewriterContentTextStyle()
    
                        +
                        Text(item.ingredient.unwrappedValue)
                            .americanTypewriterContentTextStyle()
                        +
                        Text(" : ")
                            .americanTypewriterContentTextStyle()
                        +
                        Text(item.measure.unwrappedValue)
                            .americanTypewriterContentTextStyle()
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
                Spacer()
            }
            .matchedGeometryEffect(id: "background\(id)", in: namespace)
        }
        .task {
            await viewModel.load(by: id)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .navigationViewStyle(.stack)
        .customNavigationBar(title: title) {
            
            withAnimation(.easeIn(duration: 3)) {
                isShowing = false
                presentationMode.wrappedValue.dismiss()
            }
            
        }
    }
}
