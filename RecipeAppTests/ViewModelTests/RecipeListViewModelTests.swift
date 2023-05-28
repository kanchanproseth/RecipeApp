//
//  RecipeListViewModelTests.swift
//  RecipeAppTests
//
//  Created by Kan Chanproseth on 26/05/2023.
//

import XCTest
@testable import RecipeApp

@MainActor final class RecipeListViewModelTests: XCTestCase {
    private var service: MealService!
    private var viewModel: RecipeListViewModel!
    private var meals: [MealData]!

    override func setUp() async throws {
        service = MockMealNetworkingService()
        viewModel = RecipeListViewModel(service: service)
        meals = try await service.getMealList(by: MockCagoryType.Desserts.rawValue).get().meals.compactMap({ MealData($0) })
    }
    
    override func tearDown() async throws {
        service = nil
        viewModel = nil
        meals = nil
    }

    func testSuggestionListShouldNotEmptyAfterLoad() async {
        await viewModel.loadSuggestion()
        
        XCTAssertTrue(viewModel.suggestions.count > 0)
    }
    
    func testMealSortAfterLoad() async {
        await viewModel.loadMeal(by: MockCagoryType.Desserts.rawValue)
        
        XCTAssertNotEqual(viewModel.meals, meals)
        meals = meals.compactMap{ $0 }.sorted()
        XCTAssertEqual(meals.first, viewModel.meals.first)
        XCTAssertEqual(meals.last, viewModel.meals.last)
        for i in 0..<meals.count {
            XCTAssertEqual(meals[i], viewModel.meals[i])
        }
    }
    
    func testMealListShouldNotEmptyAfterLoad() async {
        await viewModel.loadMeal(by: MockCagoryType.Desserts.rawValue)
        
        XCTAssertTrue(viewModel.meals.count > 0)
    }
    
   
    
    func testMealListShouldNotEmptyAfterSearch() async {
        await viewModel.loadMeal(by: MockCagoryType.Desserts.rawValue)
        
        XCTAssertTrue(viewModel.meals.count > 0)
    }
    
}
