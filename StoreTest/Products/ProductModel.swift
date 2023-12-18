//
//  ProductModel.swift
//  StoreTest
//
//  Created by Sofo Machurishvili on 18.12.23.
//

struct ProductModel: Decodable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let price: Float
    let discountPercentage: Float
    let rating: Float
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
    var inCart: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case id, title, description, price, discountPercentage, rating, stock, brand, category, thumbnail, images
    }
}
