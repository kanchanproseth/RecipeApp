//
//  Defaultable.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 24/05/2023.
//

import Foundation

public protocol Defaultable {
    static var defaultValue: Self { get }
}

public extension Optional where Wrapped: Defaultable {
    var unwrappedValue: Wrapped { return self ?? Wrapped.defaultValue }
}

extension Int: Defaultable {
    public static var defaultValue: Int { return 0 }
}

extension Double: Defaultable {
    public static var defaultValue: Double { return 0.0 }
}

extension String: Defaultable {
    public static var defaultValue: String { return "" }
}

extension Array: Defaultable {
    public static var defaultValue: [Element] { return [] }
}

extension Bool: Defaultable {
    public static var defaultValue: Bool { return false }
}

