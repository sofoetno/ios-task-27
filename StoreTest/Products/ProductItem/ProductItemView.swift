//
//  ProductItemView.swift
//  StoreTest
//
//  Created by Sofo Machurishvili on 18.12.23.
//

import SwiftUI

struct ProductItemView: View {
    @Binding var product: ProductModel
    
    var body: some View {

        
        NavigationLink {
            ProductDetailsView(product: product)
        } label: {
            
            VStack {
                
                HStack {
                    AsyncImage(url: URL(string: product.thumbnail)) { phase in
                        switch phase {
                        case .empty:
                            Image(systemName: "photo")
                                .frame(width: 60, height: 60)
                            
                        case .success(let image):
                            image.resizable()


                        case .failure(_):
                            Image(systemName: "photo")
                                .frame(width: 60, height: 60)
                        @unknown default:
                            EmptyView()
                                .frame(width: 60, height: 60)
                        }
                        
                    }
                    
                }
                .frame(height: 120)
                .cornerRadius(12)

                Text(product.title)
                Text("$\(String(format: "%.2f", product.price))")
                
                HStack{
                    Button {
                        if product.inCart > 0 {
                            product.inCart -= 1
                        }
                    } label: {
                        Image("minus")
                    }
                    
                    Rectangle()
                        .frame(width: 26, height: 26)
                        .foregroundColor(.white)
                        .overlay(
                            Text("\(product.inCart)")
                        )
                    
                    Button {
                        if product.inCart < product.stock {
                            product.inCart += 1
                        }
                    } label: {
                        Image("plus")
                    }
                }
                
            }

        }
    }
}

#Preview {
    ProductItemView(product:  .constant (ProductModel(id: 1, title: "Some title", description: "Some Description, Some Description, Some Description, Some Description, Some Description, Some Description", price: 15.3, discountPercentage: 2, rating: 5, stock: 100, brand: "Apple", category: "smartphones", thumbnail: "", images: [""])))
}
