//
//  CategoriesView.swift
//  StoreTest
//
//  Created by Sofo Machurishvili on 18.12.23.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var categoriesViewModel = CategoriesViewModel()
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 100, maximum: 380))
    ]
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    if categoriesViewModel.categories.count == 0 {
                        Text("Loading...")
                    } else {
                        ForEach(categoriesViewModel.categories, id: \.self) { category in
                            NavigationLink {
                                ProductsView(productsViewModel: ProductsViewModel(category: category))
                            } label: {
                                
                                Text(category)
                                    .font(.title2)
                                    .padding(.vertical, 5)
                            }
                            .frame(width: 350, height: 50)
                            .overlay(
                            RoundedRectangle(cornerRadius: 16)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.1, green: 0.58, blue: 1), lineWidth: 1))
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        }
                    }
                })

            }
            
            
            .navigationTitle("Categories")
        }
        
    }
}

#Preview {
    CategoriesView()
}
