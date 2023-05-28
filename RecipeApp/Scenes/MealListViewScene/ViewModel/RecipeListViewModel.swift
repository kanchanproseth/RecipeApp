//
//  RecipeListViewModel.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 24/05/2023.
//

import Combine

@MainActor class RecipeListViewModel: ObservableObject {
    private var service:  MealService
    @Published var searchText: String = ""
    @Published var suggestions: [String] = []
    @Published var meals: [MealData] = []
    @Published var errors: String?
    
    init(service: MealService = MealNetworkingService()) {
        self.service = service
    }
    
    // fetch list of categorry to bind to search suggestion list
    func loadSuggestion() async {
        do {
            self.suggestions = try await service.getCategories().get().categories.compactMap { $0.title }
        } catch let error {
            guard let error = error as? NetworkingError else { return }
            errors = error.customDescription
        }
    }
    
    // fetch meal from api by default call Dessert category
    func loadMeal(by category: String = "Dessert") async {
        do {
            let meals = try await service.getMealList(by: category).get().meals.compactMap({ MealData($0) })
            self.meals = meals.sorted()
        } catch  {
            guard let error = error as? NetworkingError else { return }
            errors = error.customDescription
        }
    }
}
