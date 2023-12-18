//
//  ContentView.swift
//  StoreTest
//
//  Created by Sofo Machurishvili on 18.12.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            CategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "menucard")
                }
        }
    }
}

#Preview {
    ContentView()
}
