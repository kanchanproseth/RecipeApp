//
//  RecipeAppApp.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 24/05/2023.
//

import SwiftUI

@main
struct RecipeApplication: App {
    
    @State var isActive: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
               if self.isActive {
                   MainView()
               } else {
                   SplashView()
               }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}
