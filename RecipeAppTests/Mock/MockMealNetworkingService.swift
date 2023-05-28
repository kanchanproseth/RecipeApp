//
//  MockMealServiceNetworking.swift
//  RecipeAppTests
//
//  Created by Kan Chanproseth on 26/05/2023.
//

import Foundation
import RecipeApp

struct MockMealNetworkingService: MealService {
    
    private var network: Networking
    
    init(network: Networking = NetworkingManager()) {
        self.network = network
    }
    
    func getCategories() async -> Result<CategoryEntity, NetworkingError> {
        return await network.make(target: MockMealTarget.categories, model: CategoryEntity.self)
    }
    
    func getMealList(by category: String) async -> Result<MealEntity, NetworkingError> {
        return await network.make(target: MockMealTarget.meals(category: category), model: MealEntity.self)
    }
    
    func getMealDetails(by id: String) async -> Result<MealEntity, NetworkingError> {
        return await network.make(target: MockMealTarget.mealDetails(id: id), model: MealEntity.self)
    }
}

struct MockMealNetworkingFailureService: MealService {
    
    private var network: Networking
    private var error: NetworkingError
    
    init(network: Networking = NetworkingManager(), error: NetworkingError) {
        self.error = error
        self.network = network
    }
    
    func getCategories() async -> Result<CategoryEntity, NetworkingError> {
        return .failure(error)
    }
    
    func getMealList(by category: String) async -> Result<MealEntity, NetworkingError> {
        return .failure(error)
    }
    
    func getMealDetails(by id: String) async -> Result<MealEntity, NetworkingError> {
        return .failure(error)
    }
}

