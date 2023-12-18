//
//  ProductDetailsView.swift
//  StoreTest
//
//  Created by Sofo Machurishvili on 18.12.23.
//

import SwiftUI

struct ProductDetailsView: View {
    let product: ProductModel
    
    var body: some View {

        ScrollView{
            VStack {
                HStack {
                    AsyncImage(url: URL(string: product.thumbnail)) { phase in
                        switch phase {
                        case .empty:
                            Image(systemName: "photo")
                                .frame(width: 60, height: 60)
                            
                        case .success(let image):
                            image.resizable()
                                .frame(height: 200)


                        case .failure(_):
                            Image(systemName: "photo")
                                .frame(width: 60, height: 60)
                        @unknown default:
                            EmptyView()
                                .frame(width: 60, height: 60)
                        }
                        
                    }
                    
                }
                .cornerRadius(12)
                
                Text(product.title)
                    .font(.largeTitle)
                    .padding()
                Text(product.description)
                    .padding()
                Text("$\(String(format: "%.2f", product.price))")
                    .font(.title2)
                    .fontWeight(.medium)
                
            }
            .padding(.horizontal, 20)
            
            HStack {
                NavigationLink {
                    CategoriesView()
                } label: {
                    Text("Return to Categories")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color(red: 0.1, green: 0.58, blue: 1))
                        .cornerRadius(20)

                }
            }
            .padding(.vertical, 50)
        }
        
 
    }
}

#Preview {
    ProductDetailsView(product: ProductModel(id: 1, title: "Some title", description: "Some Description, Some Description, Some Description, Some Description, Some Description, Some Description", price: 15.3, discountPercentage: 2, rating: 5, stock: 100, brand: "Apple", category: "smartphones", thumbnail: "https://i.dummyjson.com/data/products/1/thumbnail.jpg", images: [""]))
}
