//
//  ProductsViewModel.swift
//  StoreTest
//
//  Created by Sofo Machurishvili on 18.12.23.
//

import SwiftUI
import NetworkService

struct ProductsData: Decodable {
    let products: [ProductModel]
}

enum CheckoutError: Error {
    case insufficient
    case emptyCart
}

class ProductsViewModel: ObservableObject {
    var category: String? = nil
    @Published var products: [ProductModel] = []
    @Published var balance: Float = 2000.00
    @Published var checkoutInProgress: Bool = false
    
    init(category: String?) {
        self.category = category
        
        getProductsByCategory(category: category)
    }
    
    func getProductsByCategory(category: String?) {
        Task {
            do {
                let urlString = category == nil ? "https://dummyjson.com/products" : "https://dummyjson.com/products/category/\(category ?? "")"
                if let productsData: ProductsData = try await NetworkService.shared.getData(fromUrl: urlString) {
                    await MainActor.run {
                        self.products = productsData.products
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func calculateSubtotalPrice() -> Float {
        let totalPrice = products.reduce(0) { $0 + $1.price * Float($1.inCart) }
        
        return totalPrice
    }
    
    func calculateQuantity() -> Int {
        products.reduce(0) { $0 + $1.inCart }
    }
    
    func removeAll() {
        products = products.map { product in
            var updateProduct = product
            updateProduct.inCart = 0
            return updateProduct
        }
    }
    
    func checkout() async throws {
        await MainActor.run {
            checkoutInProgress = true
        }
        
        let quantity = calculateQuantity()
        
        if quantity == 0 {
            await MainActor.run {
                checkoutInProgress = false
            }
            throw CheckoutError.emptyCart
        }
        
        let totalPrice = calculateSubtotalPrice()
        
        if totalPrice > balance {
            await MainActor.run {
                checkoutInProgress = false
            }
            throw CheckoutError.insufficient
        }
        
        try await Task.sleep(nanoseconds: 3000000000)
        await MainActor.run {
            balance -= totalPrice
            removeAll()
            checkoutInProgress = false
        }
       
    }
}
