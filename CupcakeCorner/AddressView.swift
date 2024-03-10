//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Margarita Mayer on 16/01/24.
//

import SwiftUI

struct AddressView: View {
    
    @Bindable var order: Order
    
    
    var body: some View {
        
        Form {
            Section {
                
                TextField("Name", text: $order.address.name)
                
                TextField("Street address", text: $order.address.streetAddress)
                
                TextField("City", text: $order.address.city)
                
                TextField("Zip", text: $order.address.zip)
                
            }
            
            Section {
                NavigationLink("Checkout") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
      
    }
}

#Preview {
    AddressView(order: Order())
}
