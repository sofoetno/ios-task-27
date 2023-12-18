//
//  CategoriesViewModel.swift
//  StoreTest
//
//  Created by Sofo Machurishvili on 18.12.23.
//

import SwiftUI
import NetworkService

class CategoriesViewModel: ObservableObject {
    @Published var categories: [String] = []
    
    init() {
        getCategories()
    }
    
    func getCategories() {
        Task {
            do {
                if let categories: [String] = try await NetworkService.shared.getData(fromUrl: "https://dummyjson.com/products/categories") {
                    self.categories = categories
                }
            } catch {
                print(error)
            }
        }
    }
}
