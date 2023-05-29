//
//  SplashView.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 28/05/2023.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        ZStack {
            Image("recipe_app_background")
                .ignoresSafeArea()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
