//
//  ImageCacheTests.swift
//  RecipeAppTests
//
//  Created by Kan Chanproseth on 26/05/2023.
//

import XCTest
import UIKit
import RecipeApp

@MainActor final class ImageCacheTests: XCTestCase {
    
    var imageCache: ImageCache!
    var testUrl: String!
    var url: URL!
    var testImage: UIImage!

    override func setUp() {
        imageCache = ImageCache()
        testUrl = "https://www.themealdb.com/images/media/meals/vxuyrx1511302687.jpg"
        testImage = UIImage(named: "recipe_app_background")
        url = URL(string:testUrl)!
    }

    override func tearDown() {
        imageCache = nil
        testUrl = nil
        testImage = nil
        url = nil
    }
    
    
    func testInsertImageAndGetImageBack() {
        imageCache.insertImage(testImage, for: url)
        let returnImage = imageCache.image(for: url)
        XCTAssertNotNil(returnImage)
        
        let imageData = testImage?.pngData()
        let returnImageData = returnImage?.pngData()
        XCTAssertEqual(imageData, returnImageData)
    }
    
    func testRemoveImageByUrl() {
        imageCache.insertImage(testImage, for: url)
        var returnImage = imageCache.image(for: url)
        XCTAssertNotNil(returnImage)
        
        imageCache.removeImage(for: url)
        returnImage = imageCache.image(for: url)
        XCTAssertNil(returnImage)
    }
    
    func testRemoveAll() {
        imageCache.insertImage(testImage, for: url)
        var returnImage = imageCache.image(for: url)
        XCTAssertNotNil(returnImage)
        
        imageCache.removeAllImages()
        returnImage = imageCache.image(for: url)
        XCTAssertNil(returnImage)
    }
}
