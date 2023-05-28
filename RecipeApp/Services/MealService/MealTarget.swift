//
//  MealTarget.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 24/05/2023.
//

import Foundation

enum MealTarget {
    case categories
    case meals(category: String)
    case mealDetails(id: String)
}

extension MealTarget: NetworkTarget {
    var path: String {
        switch self {
        case .categories: return "/categories.php"
        case .meals: return "/filter.php"
        case .mealDetails: return "/lookup.php"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .meals(let category):
            return [URLQueryItem(name: "c", value: category)]
        case .mealDetails(let id):
            return [URLQueryItem(name: "i", value: "\(id)")]
        default:
            return nil
        }
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var body: [String : String]? {
        return nil
    }
    
    var sampleData: Data? {
        return nil
    }
}
