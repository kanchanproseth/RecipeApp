//
//  DefaultableTests.swift
//  RecipeAppTests
//
//  Created by Kan Chanproseth on 26/05/2023.
//

import XCTest
import RecipeApp


final class DefaultableTests: XCTestCase {
    
    var testInt: Int?
    var testDouble: Double?
    var testString: String?
    var testArray: [Int]?
    var testBool: Bool?
    
    override func tearDown() {
        testInt = nil
        testDouble = nil
        testString = nil
        testArray = nil
        testBool = nil
    }
    
    func testUnwrapNilExpectingDefault() {
        XCTAssertEqual(testInt.unwrappedValue, 0)
        XCTAssertEqual(testDouble.unwrappedValue, 0.0)
        XCTAssertEqual(testString.unwrappedValue, "")
        XCTAssertEqual(testArray.unwrappedValue, [])
        XCTAssertEqual(testBool.unwrappedValue, false)
    }
    
    func testUnwrapvalueNotNilExpectingValue() {
        testInt = 1
        testDouble = 1.2321
        testString = "test"
        testArray = [1]
        testBool = true
        
        XCTAssertEqual(testInt.unwrappedValue, 1)
        XCTAssertEqual(testDouble.unwrappedValue, 1.2321)
        XCTAssertEqual(testString.unwrappedValue, "test")
        XCTAssertEqual(testArray.unwrappedValue, [1])
        XCTAssertEqual(testBool.unwrappedValue, true)
    }
}
