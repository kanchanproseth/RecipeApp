//
//  Meal.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 24/05/2023.
//

import Foundation

// MARK: MealData
struct MealData: Identifiable, Hashable {
    var id: String?
    var title: String?
    var imageUrl: String?
    
    // custom key for dictionary mapping
    private enum Keys: String {
        case idMeal
        case strMeal
        case strMealThumb
        
    }
    
    // dictionary mapping to model
    init(_ param: [String: String?]) {
        id = param[Keys.idMeal.rawValue] as? String
        title = param[Keys.strMeal.rawValue] as? String
        imageUrl = param[Keys.strMealThumb.rawValue] as? String
    }
}

// MARK: MealData: Comparable for sort
extension MealData: Comparable {
    static func ==(lhs: MealData, rhs: MealData) -> Bool {
        return lhs.title == rhs.title
    }
    
    static func <(lhs: MealData, rhs: MealData) -> Bool {
        return lhs.title.unwrappedValue < rhs.title.unwrappedValue
    }
}
