//
//  RecipeDetailsViewModelTests.swift
//  RecipeAppTests
//
//  Created by Kan Chanproseth on 26/05/2023.
//

import XCTest
@testable import RecipeApp

@MainActor final class RecipeDetailsViewModelTests: XCTestCase {
    private var service: MockMealNetworkingService!
    private var viewModel: RecipeDetailsViewModel!

    @MainActor override func setUp() {
        super.setUp()
        service = MockMealNetworkingService()
        viewModel = RecipeDetailsViewModel(service: service)
    }

    func testIngredientsShouldNotNil() async {
        await viewModel.load(by: "52855")
        
        XCTAssertNotNil(viewModel.ingredients)
       
    }
    
     func testTitleShouldNotNilAfterLoad() async {
         await viewModel.load(by: "52855")
        
         XCTAssertNotNil(viewModel.title)
    }
    
   
    
    func testImageUrlShouldNotNilAfterLoad() async {
        await viewModel.load(by: "52855")
        
        XCTAssertNotNil(viewModel.imageUrl)
    }
    
    func testInstructionShouldNotNilAfterLoad() async {
        await viewModel.load(by: "52855")
        
        XCTAssertNotNil(viewModel.instructions)
    }
}
