//
//  HomeView.swift
//  StoreTest
//
//  Created by Sofo Machurishvili on 18.12.23.
//

import SwiftUI

struct MainView: View {
    @StateObject var productsViewModel = ProductsViewModel(category: nil)
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    

    
    var body: some View {
        
        NavigationStack {
            VStack {
                HStack {
                    Text("Balane: $\(String(format: "%.2f", productsViewModel.balance))")
                        .frame(width: 150, height: 50)
                        .background(.white)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.1, green: 0.58, blue: 1), lineWidth: 1))
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    Spacer()
                    
                    VStack(spacing: 5) {
                        Text("Items: \(productsViewModel.calculateQuantity())")
                        Text("Total: $\(String(format: "%.2f", productsViewModel.calculateSubtotalPrice()))")
                    }
                    .frame(width: 150, height: 50)
                    .background(.white)
                    .cornerRadius(16)
                    .overlay(
                    RoundedRectangle(cornerRadius: 16)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.1, green: 0.58, blue: 1), lineWidth: 1))
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                }
                .padding(.horizontal, 20)
        
                ScrollView {
                    ProductsView(productsViewModel: productsViewModel)
                }

                HStack {
                    Button {
                        Task {
                            do {
                                try await productsViewModel.checkout()
                                alertMessage = "Congrats! Your purchase is completed!"
                            } catch {
                                switch error {
                                case CheckoutError.emptyCart:
                                    alertMessage = "Your cart is empty"
                                case CheckoutError.insufficient:
                                    alertMessage = "Not enough balance"
                                default:
                                    alertMessage = "Something goes wrong"
                                }
                            }
                            
                            showAlert = true
                        }
                    } label: {
                        Text(productsViewModel.checkoutInProgress ? "Loadng..." : "Chek out")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                    .disabled(productsViewModel.checkoutInProgress)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text(alertMessage),
                            dismissButton: .destructive(
                                Text("Ok")
                               
                            )
                        )
                    }
                    
                }
                
                .frame(maxWidth: .infinity, maxHeight: 90, alignment: .center)
                .background(Color(red: 0.1, green: 0.58, blue: 1))
                .cornerRadius(20)
                .padding(.horizontal, 30)
            
               
            }
        }
    }
}

#Preview {
    MainView()
}
