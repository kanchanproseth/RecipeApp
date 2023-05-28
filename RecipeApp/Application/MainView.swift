//
//  MainView.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 24/05/2023.
//

import SwiftUI

// MARK: MainView
struct MainView: View {
    var body: some View {
        NavigationStack {
            RecipeListView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
