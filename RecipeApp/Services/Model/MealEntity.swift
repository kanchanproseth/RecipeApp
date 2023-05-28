//
//  Meal.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 24/05/2023.
//

import Foundation

// MARK: - MealEntity
public struct MealEntity: Codable {
    // just because meal and mealDetails share data and the model not follow standard RestAPI response
    // due to measure and ingredient, I decided to map it as dictionary pass it to MealDetails.swift and MealData.swift
    let meals: [[String: String?]]
}

