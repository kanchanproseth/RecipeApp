# RecipeApp
 
RecipeApp is just an assignment application.


## Application structure

The application uses SwiftUI with MVVM.

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
 
 ![alt text](https://github.com/kanchanproseth/RecipeApp/blob/main/screenshots/1.png)
 
 
 ![alt text](https://github.com/kanchanproseth/RecipeApp/blob/main/screenshots/2.png)
 
 
 ## Network Layer
 
In this application, I separate the network layer. Network Target improve the network layer easier to test and clean. it's a place we manage our routes URL, path, query param, httpMethod... and more. 

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

It's really interesting that API response is not followed by standard RestApi responses but it's good to know how to deal with this problem because I used to face some Api much worst than this. It's not the best solution so if you have any feedback, please share it with me. I am happy to learn from other people's perspectives.

#### This is a normal mapping using codable. The more standard of restApi response, the less work we have to deal with model mapping.
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

#### Once I got the meals array of the dictionary, I pass it to map in the separate model for MealData and MealDetails with custom key mapping dictionary
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

## What could have done if I work on a real project?

- Dependency Injection SwiftUI, what I'd ever used before with UIkit is Coordinator Pattern or VIPER. It helps to manage to coordinate route view and inject.
- Application setup should have a flavour to manage separate environments and target SIT, UAT, and PROD.
- Reachability (Internet network check).
- The list should have pull refresh, and infinite scroll if the API implements pagination.
- CI/CD, set up Fastlane and automate the build and push to Firebase app distribution for the tester to be able to download test application from there and also achieve and push a build to Apple connect when we merge code to the Main branch.RecipeApp is just an assignment application.


#### Once again please share with me what you think and feed me because I really need that for the improvement and development of my skills as well as my career.

#### Thank you so much for spending your valuable time reading and review this.
