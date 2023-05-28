//
//  Text+Extensions.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 25/05/2023.
//

import SwiftUI

extension Text {

    func primaryNavigationBarTextStyle() -> Text {
        self.font(.custom("AmericanTypewriter",fixedSize: 16))
    }

    func americanTypewriterContentTextStyle() -> Text {
        self.font(.custom("AmericanTypewriter",fixedSize: 12))
    }
    
    func americanTypewriterSubTitleTextStyle() -> Text {
        self.font(.custom("AmericanTypewriter",fixedSize: 14).weight(.medium))
    }
    
    func americanTypewriterTitleTextStyle() -> Text {
        self.font(.custom("AmericanTypewriter",fixedSize: 14).weight(.semibold))
    }
    
    func americanTypewriterTitleTextStyle2() -> Text {
        self.font(.custom("AmericanTypewriter",fixedSize: 14).weight(.semibold))
    }
}
