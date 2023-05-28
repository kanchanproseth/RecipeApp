//
//  RecipeDetailsViewModelFailureTests.swift
//  RecipeAppTests
//
//  Created by Kan Chanproseth on 26/05/2023.
//

import XCTest
@testable import RecipeApp

@MainActor final class RecipeDetailsViewModelFailureTests: XCTestCase {
    private var service: MealService!
    private var viewModel: RecipeDetailsViewModel!

    override func setUp() async throws {
        service = MockMealNetworkingFailureService(error: .invalidUrl)
        viewModel = RecipeDetailsViewModel(service: service)
    }
    
    override func tearDown() async throws {
        service = nil
        viewModel = nil
    }

    func testMealListListShouldFailAfterLoad() async {
        await viewModel.load(by: "52855")

        XCTAssertEqual(viewModel.errors, "Invalid Url error")
    }

}

