//
//  MockMealTarget.swift
//  RecipeAppTests
//
//  Created by Kan Chanproseth on 26/05/2023.
//

import Foundation
import RecipeApp

enum MockMealTarget {
    case categories
    case meals(category: String)
    case mealDetails(id: String)
}

enum MockCagoryType: String {
    case Desserts
    case Chicken
    case Miscellaneous
}

extension MockMealTarget: NetworkTarget {
    
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
        switch self {
        case .categories:
            return readLocalJSONFile(forName: "Categories")
        case .meals(let category):
            return sampleData(by: category)
        case .mealDetails:
            return readLocalJSONFile(forName: "MealDetails")
        }
    }
    
    
}

extension MockMealTarget {
    func sampleData(by categoory: String) -> Data? {
        guard let type = MockCagoryType(rawValue: categoory) else { return nil }
        return readLocalJSONFile(forName: type.rawValue)
    }
    
    func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}
