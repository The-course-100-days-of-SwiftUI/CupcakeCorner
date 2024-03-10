//
//  Order.swift
//  CupcakeCorner
//
//  Created by Margarita Mayer on 16/01/24.
//

import Foundation

@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequest = "specialRequest"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequest = false {
        didSet {
            if specialRequest == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var address = Address() {
        didSet {
            if let encoded = try? JSONEncoder().encode(address) {
                UserDefaults.standard.set(encoded, forKey: "Address")
            }
        }
    }

    
    var hasValidAddress: Bool {
        
        if address.name.isEmpty || address.streetAddress.isEmpty || address.city.isEmpty || address.zip.isEmpty || (address.name.allSatisfy {$0 == " " }) || (address.streetAddress.allSatisfy {$0 == " " }) || (address.city.allSatisfy {$0 == " " }) || (address.zip.allSatisfy {$0 == " " }){
            return false
        }
        return true
    }
    
    var cost: Decimal {
        
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type) / 2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
    
    init() {
        if let savedAddress = UserDefaults.standard.data(forKey: "Address") {
            if let decodedAddress = try? JSONDecoder().decode(Address.self, from: savedAddress) {
                address = decodedAddress
                return
            }
        }
        address = Address()
    }
}


@Observable
class Address: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
    }
    
    var name: String = ""
    var streetAddress: String = ""
    var city: String = ""
    var zip: String = ""
}
