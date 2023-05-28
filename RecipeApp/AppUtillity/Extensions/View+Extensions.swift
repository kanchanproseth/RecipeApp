//
//  View+Extensions.swift
//  RecipeApp
//
//  Created by Kan Chanproseth on 25/05/2023.
//

import SwiftUI

extension View {
    func customNavigationBar(title: String, _ completion: @escaping () -> Void) -> some View {
        self.toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Button {
                        completion()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                                .tint(Color.gray)
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text(title)
                            .primaryNavigationBarTextStyle()
                            .multilineTextAlignment(.leading)
                            .padding()
                            .foregroundColor(Color.gray)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        
                    }
                }
            }
        }
    }
}
