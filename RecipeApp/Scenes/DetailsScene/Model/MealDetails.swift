//
//  MealDetails.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 24/05/2023.
//

import Foundation

// MARK: MealDetails
struct MealDetails {
    var title: String?
    var imageUrl: String?
    var instructions: String?
    var ingredients: [IngredienAndMeasure]?
    
    // custom key for dictionary mapping
    private enum Keys: String {
        case strMeal
        case strMealThumb
        case strInstructions
        case strIngredient
        case strMeasure
        
    }
    
    init(_ param: [String: String?]) {
        title = param[Keys.strMeal.rawValue] as? String
        imageUrl = param[Keys.strMealThumb.rawValue] as? String
        instructions = param[Keys.strInstructions.rawValue] as? String
        
        /*
         each measure depend on ingredient so number of measure should be the same as ingredient.
         base on this logic if the api response more key of ingredient, it should be fine because
         I filter and map.
        */
        let ingredentKeys = param.keys.filter { $0.contains(Keys.strIngredient.rawValue) }
        var items = [IngredienAndMeasure]()

        for i in 1...ingredentKeys.count {
            if let ingredient = param["\(Keys.strIngredient.rawValue)\(i)"] as? String,
               let measure = param["\(Keys.strMeasure.rawValue)\(i)"] as? String {
                let item = IngredienAndMeasure(id: i, ingredient: ingredient, measure: measure)
                items.append(item)
            }
        }
        ingredients = items
        
    }
}

// MARK: IngredienAndMeasure
struct IngredienAndMeasure: Hashable, Identifiable {
    var id: Int
    var ingredient: String?
    var measure: String?
}
