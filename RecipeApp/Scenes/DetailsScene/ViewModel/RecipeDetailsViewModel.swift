//
//  RecipeDetailsViewModel.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 25/05/2023.
//

import Combine

// MARK: RecipeDetailsViewModel
@MainActor class RecipeDetailsViewModel: ObservableObject {
    private var service:  MealService
    @Published var imageUrl: String?
    @Published var title: String?
    @Published var instructions: String?
    @Published var ingredients: [IngredienAndMeasure]?
    @Published var errors: String?
    
    init(service: MealService = MealNetworkingService()) {
        self.service = service
    }
    
    // fetch meal details by id
    func load(by id: String) async {
        do {
            let result = try await service.getMealDetails(by: id).get().meals.compactMap({ MealDetails($0) }).first
            self.imageUrl = result?.imageUrl
            self.title = result?.title
            self.instructions = result?.instructions
            self.ingredients = result?.ingredients?.filter{ !$0.ingredient.unwrappedValue.isEmpty && !$0.measure.unwrappedValue.isEmpty }
        } catch  {
            guard let error = error as? NetworkingError else { return }
            errors = error.customDescription
        }
    }
}

