//
//  RecipeListView.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 24/05/2023.
//

import SwiftUI

// MARK: RecipeListView
struct RecipeListView: View {
    @Namespace var namespace
    @StateObject var viewModel = RecipeListViewModel()
    @State private var selectedModel: MealData?
    @State private var isShowingCard: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if  isShowingCard {
                    if let selectedModel = selectedModel {
                        RecipeDetailsView(
                            isShowing: $isShowingCard,
                            namespace: namespace,
                            id: selectedModel.id.unwrappedValue,
                            title: selectedModel.title.unwrappedValue
                        )
                    }
                } else {
                    GeometryReader { initView in
                        ScrollView {
                            LazyVStack {
                                ForEach(viewModel.meals, id: \.id) { meal in
                                    GeometryReader { animateView in
                                        RecipeItemView(
                                            namespace: namespace,
                                            isShowing: $isShowingCard,
                                            selectedModel: $selectedModel,
                                            data: meal
                                        )
                                        .padding(25)
                                        .scaleEffect(dimensionValue(
                                            init: initView.frame(in: .global).minY,
                                            minY: animateView.frame(in: .global).minY
                                        ))
                                    }.frame(height: 125)
                                }
                            }
                        }
                        .task {
                            await viewModel.loadSuggestion()
                            await viewModel.loadMeal()
                        }
                        .refreshable {
                            Task {
                                await viewModel.loadSuggestion()
                                await viewModel.loadMeal(by: viewModel.searchText)
                            }
                        }
                        .searchable(text: $viewModel.searchText,
                                    placement: .navigationBarDrawer(displayMode: .always),
                                    prompt: "Search by category",
                                    suggestions: {
                            ForEach(viewModel.suggestions.filter {
                                $0.localizedCaseInsensitiveContains(viewModel.searchText)
                            }, id: \.self) { suggestion in
                                Button {
                                    viewModel.searchText = suggestion
                                    Task { await viewModel.loadMeal(by: suggestion) }
                                } label: {
                                    Label(suggestion, systemImage: "filemenu.and.selection")
                                }
                            }
                        })
                        .padding(.top, 25)
                        .background(.clear)
                    }
                    .background(.clear)
                    .zIndex(1)
                    .navigationBarTitle("Recipe App")
                }
            }
        }
        .navigationViewStyle(.stack)
        .animation(.default, value: isShowingCard)
        .zIndex(0)
    }

    
    func dimensionValue(init frame: CGFloat, minY: CGFloat) -> CGFloat {
        withAnimation(.easeIn(duration: 3)) {
            let dimension = (minY - 25) / frame
            if dimension > 1 {
                return 1
            } else {
                return dimension
            }
            
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        return RecipeListView()
    }
}
