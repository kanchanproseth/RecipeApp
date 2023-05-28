//
//  NetworkTargetTests.swift
//  RecipeAppTests
//
//  Created by Kan Chanproseth on 26/05/2023.
//

import XCTest
@testable import RecipeApp

@MainActor final class NetworkTargetTests: XCTestCase {
    private var target: MockMealTarget!
    private var network: Networking!
    
    
    
    override func setUpWithError() throws {
        target = MockMealTarget.categories
        network = NetworkingManager()
    }

    override func tearDownWithError() throws {
        target = nil
    }
    
    func testTargetCategoriesParseURL() {
        target = MockMealTarget.categories
        let url = network.parseUrl(target)
        
        let host = "themealdb.com"
        let scheme = "https"
        let path = "/api/json/v1/1" + "/categories.php"
        var urlComponent = URLComponents()
        urlComponent.scheme = scheme
        urlComponent.host = host
        urlComponent.path = path
        
        
        XCTAssertEqual(url, urlComponent.url)
        XCTAssertEqual(url?.absoluteString, "https://themealdb.com/api/json/v1/1/categories.php")
    }
    
    func testTargetMealParseURL() {
        target = MockMealTarget.meals(category: "Test")
        let url = network.parseUrl(target)
        
        let host = "themealdb.com"
        let scheme = "https"
        let path = "/api/json/v1/1" + "/filter.php"
        let queryItem = URLQueryItem(name: "c", value: "Test")
        var urlComponent = URLComponents()
        urlComponent.scheme = scheme
        urlComponent.host = host
        urlComponent.path = path
        urlComponent.queryItems = [queryItem]
        
        
        XCTAssertEqual(url, urlComponent.url)
        
        XCTAssertEqual(url?.absoluteString, "https://themealdb.com/api/json/v1/1/filter.php?c=Test")
    }
    
    func testTargetMealDetailsParseURL() {
        target = MockMealTarget.mealDetails(id: "123")
        let url = network.parseUrl(target)
        
        let host = "themealdb.com"
        let scheme = "https"
        let path = "/api/json/v1/1" + "/lookup.php"
        let queryItem = URLQueryItem(name: "i", value: "123")
        var urlComponent = URLComponents()
        urlComponent.scheme = scheme
        urlComponent.host = host
        urlComponent.path = path
        urlComponent.queryItems = [queryItem]
        
        
        XCTAssertEqual(url, urlComponent.url)
    }
}
