//
//  MealService.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 24/05/2023.
//

import Foundation

public protocol MealService {
    func getCategories() async -> Result<CategoryEntity, NetworkingError>
    func getMealList(by category: String) async -> Result<MealEntity, NetworkingError>
    func getMealDetails(by id: String) async -> Result<MealEntity, NetworkingError>
}

struct MealNetworkingService: MealService {
    
    private var network: Networking
    
    init(network: Networking = NetworkingManager()) {
        self.network = network
    }
    
    func getCategories() async -> Result<CategoryEntity, NetworkingError> {
        return await network.make(target: MealTarget.categories, model: CategoryEntity.self)
    }
    
    func getMealList(by category: String) async -> Result<MealEntity, NetworkingError> {
        return await network.make(target: MealTarget.meals(category: category), model: MealEntity.self)
    }
    
    func getMealDetails(by id: String) async -> Result<MealEntity, NetworkingError> {
        return await network.make(target: MealTarget.mealDetails(id: id), model: MealEntity.self)
    }
}


