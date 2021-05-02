//
//  OrderAddress.swift
//  Waamde
//
//  Created by Sunil Kumar on 02/04/21.
//

import Foundation
struct OrderAddressModel {
    var address:String?
    var city:String?
    var zipCode:String?
    var state:String?
    var name:String?
    var phone:String?
    var paymentType:String?
    init() {
    }
    init(address:String,city:String,zipCode:String,state:String,name:String,phone:String,paymentType:String) {
        self.address = address
        self.city = city
        self.zipCode = zipCode
        self.state = state
        self.name = name
        self.phone = phone
        self.paymentType = paymentType
    }
}
