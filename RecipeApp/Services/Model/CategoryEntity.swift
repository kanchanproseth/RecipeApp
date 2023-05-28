//
//  CategoryEntity.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 26/05/2023.
//

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
