//
//  RecipeListViewModelFailureTests.swift
//  RecipeAppTests
//
//  Created by Kan Chanproseth on 26/05/2023.
//

import XCTest
@testable import RecipeApp

@MainActor final class RecipeListViewModelFailureTests: XCTestCase {
    private var service: MealService!
    private var viewModel: RecipeListViewModel!

    override func setUp() async throws {
        service = MockMealNetworkingFailureService(error: .invalidUrl)
        viewModel = RecipeListViewModel(service: service)
    }
    
    override func tearDown() async throws {
        service = nil
        viewModel = nil
    }

    func testMealListListShouldFailAfterLoad() async {
        await viewModel.loadMeal()

        XCTAssertEqual(viewModel.errors, "Invalid Url error")
    }

    func testSuggestionListShouldFailAfterLoad() async {
        await viewModel.loadSuggestion()

        XCTAssertEqual(viewModel.errors, "Invalid Url error")

    }
    
    func testSuggestionListShouldFailAfterSearch() async {
        await viewModel.loadMeal(by: "")

        XCTAssertEqual(viewModel.errors, "Invalid Url error")

    }
}
