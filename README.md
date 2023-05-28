# RecipeApp
 
RecipeApp is just an assignment application of the company I really want to join. Hopefully I have a chance to join their team.


## Application structure

The application using SwiftUI with MVVM.
```
-> RecipeApp

   -> Services (separate service api request for mock purpose as well as testing)
        -> Model
        -> MealService
        
   -> AppUtillity
        -> Extensions
        -> ImageViewer
        -> Networking
        
   -> Application
    
   -> Scenes
        -> DetailsScene
           -> View
           -> ViewModel
           -> Model
        -> MealListViewScene
           -> View
           -> ViewModel
           -> Model
 ```
 
 ```
-> RecipeAppTests (Code Coverage from 75 - 100% which is not including UI) 
    -> AppUtillityTests
    -> Mock
    -> NetworkingTests
    -> ViewModelTests
 ```
 
 ## Network Layer
 
In this application, I separate network layer. Network Target improve the network layer easier to test and clean. it's a place we manage our routes url, path, query param, httpMethod... and more. 

#### Base Network Target: configure base url, httpMethod, type ...
```swift
public enum NetworkType: String, CaseIterable {
    case http, https
}

public enum HttpMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

public protocol NetworkTarget {
    var type: NetworkType { get }
    var base: String { get }
    var basePath: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var header: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: String]? { get }
    var sampleData: Data? { get }
}

extension NetworkTarget {
    public var type: NetworkType {
        return .https
    }

    public var base: String {
        return "themealdb.com"
    }
    
    public var basePath: String {
         return "/api/json/v1/1"
    }
}
```
#### MealTarget: specifically Target for meal request
```swift
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
```

## Model and Data Mapping

It's really interesting that api response is not follow by standard RestApi Reponse but it's good know how to deal with this problems because I used to face some Api much worst than this. It's not the best solution so if you have any feed back, please share it to me. I am happy to learn from other people perspective.

#### This is normal mapping using codable. The more standard of restApi response, the less work we have to deal with model mapping.

```swift
import Foundation

// MARK: - CategoryEntity
public struct CategoryEntity: Codable {
    let categories: [Category]
}

// MARK: - Category
public struct Category: Codable {
    public let id: String
    public let title: String
    public let imageUrl: String
    public let description: String
    
    private enum CodingKeys : String, CodingKey {
        case id = "idCategory"
        case title = "strCategory"
        case imageUrl = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}

```
 
```swift
import Foundation

// MARK: - MealEntity
public struct MealEntity: Codable {
    // just because meal and mealDetails share data and the model not follow standard RestAPI response
    // due to measure and ingredient, I decided to map it as dictionary pass it to MealDetails.swift and MealData.swift
    let meals: [[String: String?]]
}
```

#### Once I got the meals array of dictionary, I pass it to map in separate model for MealData and MealDetails with custom key mapping dictionary
```swift
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
```

```swift
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
```

## What could have done if I work on real project?

- I would consider Dependency Injection SwiftUI. what I'd ever use before with UIkit is Coordinator Pattern or VIPER. It help managing coordinate route view and inject.
- Application setup should have flavour to manage separate environment and target for SIT, UAT, PROD.
- Reachabillity (Internet network check).
- List should have pull refresh, infinite scroll if api implement pagination.


#### Once again please share me what you think and feed because I really need that for my improvement and development of my skills as well as my career.

#### Thank you so much for spending your valuable time to read and review this.
