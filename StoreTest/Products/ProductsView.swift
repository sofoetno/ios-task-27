//
//  ProductsView.swift
//  StoreTest
//
//  Created by Sofo Machurishvili on 18.12.23.
//

import SwiftUI

struct ProductsView: View {
    @StateObject var productsViewModel: ProductsViewModel
    let columns: [GridItem] = [
        GridItem(.flexible(maximum: 350)),
        GridItem(.flexible(maximum: 350)),
        
    ]
    var body: some View {
        
        LazyVGrid(columns: columns,  content: {
            ForEach($productsViewModel.products, id: \.id) { product in
                ProductItemView(product: product)
            }
        })
        .padding()
        
        
        
    }
}

#Preview {
    ProductsView(productsViewModel: ProductsViewModel(category: "Smartphones"))
}
