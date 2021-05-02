/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct OrderDetail : Codable {
    let id : Int?
    let user_id : String?
    let cart : [OrderCart]?
    let method : String?
    let shipping : String?
    let pickup_location : String?
    let totalQty : String?
    let pay_amount : String?
    let txnid : String?
    let charge_id : String?
    let order_number : String?
    let payment_status : String?
    let customer_email : String?
    let customer_name : String?
    let customer_country : String?
    let customer_phone : String?
    let customer_address : String?
    let customer_city : String?
    let customer_zip : String?
    let order_type : String?
    let shipping_name : String?
    let shipping_country : String?
    let shipping_email : String?
    let shipping_phone : String?
    let shipping_address : String?
    let shipping_city : String?
    let shipping_zip : String?
    let order_note : String?
    let coupon_code : String?
    let coupon_discount : String?
    let cancel_order_reason : String?
    let status : String?
    let created_at : String?
    let updated_at : String?
    let affilate_user : String?
    let affilate_charge : String?
    let currency_sign : String?
    let currency_value : String?
    let shipping_cost : String?
    let packing_cost : String?
    let tax : String?
    let dp : String?
    let pay_id : String?
    let vendor_shipping_id : String?
    let vendor_packing_id : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case cart = "cart"
        case method = "method"
        case shipping = "shipping"
        case pickup_location = "pickup_location"
        case totalQty = "totalQty"
        case pay_amount = "pay_amount"
        case txnid = "txnid"
        case charge_id = "charge_id"
        case order_number = "order_number"
        case payment_status = "payment_status"
        case customer_email = "customer_email"
        case customer_name = "customer_name"
        case customer_country = "customer_country"
        case customer_phone = "customer_phone"
        case customer_address = "customer_address"
        case customer_city = "customer_city"
        case customer_zip = "customer_zip"
        case order_type = "order_type"
        case shipping_name = "shipping_name"
        case shipping_country = "shipping_country"
        case shipping_email = "shipping_email"
        case shipping_phone = "shipping_phone"
        case shipping_address = "shipping_address"
        case shipping_city = "shipping_city"
        case shipping_zip = "shipping_zip"
        case order_note = "order_note"
        case coupon_code = "coupon_code"
        case coupon_discount = "coupon_discount"
        case cancel_order_reason = "cancel_order_reason"
        case status = "status"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case affilate_user = "affilate_user"
        case affilate_charge = "affilate_charge"
        case currency_sign = "currency_sign"
        case currency_value = "currency_value"
        case shipping_cost = "shipping_cost"
        case packing_cost = "packing_cost"
        case tax = "tax"
        case dp = "dp"
        case pay_id = "pay_id"
        case vendor_shipping_id = "vendor_shipping_id"
        case vendor_packing_id = "vendor_packing_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        cart = try values.decodeIfPresent([OrderCart].self, forKey: .cart)
        method = try values.decodeIfPresent(String.self, forKey: .method)
        shipping = try values.decodeIfPresent(String.self, forKey: .shipping)
        pickup_location = try values.decodeIfPresent(String.self, forKey: .pickup_location)
        totalQty = try values.decodeIfPresent(String.self, forKey: .totalQty)
        pay_amount = try values.decodeIfPresent(String.self, forKey: .pay_amount)
        txnid = try values.decodeIfPresent(String.self, forKey: .txnid)
        charge_id = try values.decodeIfPresent(String.self, forKey: .charge_id)
        order_number = try values.decodeIfPresent(String.self, forKey: .order_number)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        customer_email = try values.decodeIfPresent(String.self, forKey: .customer_email)
        customer_name = try values.decodeIfPresent(String.self, forKey: .customer_name)
        customer_country = try values.decodeIfPresent(String.self, forKey: .customer_country)
        customer_phone = try values.decodeIfPresent(String.self, forKey: .customer_phone)
        customer_address = try values.decodeIfPresent(String.self, forKey: .customer_address)
        customer_city = try values.decodeIfPresent(String.self, forKey: .customer_city)
        customer_zip = try values.decodeIfPresent(String.self, forKey: .customer_zip)
        order_type = try values.decodeIfPresent(String.self, forKey: .order_type)
        shipping_name = try values.decodeIfPresent(String.self, forKey: .shipping_name)
        shipping_country = try values.decodeIfPresent(String.self, forKey: .shipping_country)
        shipping_email = try values.decodeIfPresent(String.self, forKey: .shipping_email)
        shipping_phone = try values.decodeIfPresent(String.self, forKey: .shipping_phone)
        shipping_address = try values.decodeIfPresent(String.self, forKey: .shipping_address)
        shipping_city = try values.decodeIfPresent(String.self, forKey: .shipping_city)
        shipping_zip = try values.decodeIfPresent(String.self, forKey: .shipping_zip)
        order_note = try values.decodeIfPresent(String.self, forKey: .order_note)
        coupon_code = try values.decodeIfPresent(String.self, forKey: .coupon_code)
        coupon_discount = try values.decodeIfPresent(String.self, forKey: .coupon_discount)
        cancel_order_reason = try values.decodeIfPresent(String.self, forKey: .cancel_order_reason)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        affilate_user = try values.decodeIfPresent(String.self, forKey: .affilate_user)
        affilate_charge = try values.decodeIfPresent(String.self, forKey: .affilate_charge)
        currency_sign = try values.decodeIfPresent(String.self, forKey: .currency_sign)
        currency_value = try values.decodeIfPresent(String.self, forKey: .currency_value)
        shipping_cost = try values.decodeIfPresent(String.self, forKey: .shipping_cost)
        packing_cost = try values.decodeIfPresent(String.self, forKey: .packing_cost)
        tax = try values.decodeIfPresent(String.self, forKey: .tax)
        dp = try values.decodeIfPresent(String.self, forKey: .dp)
        pay_id = try values.decodeIfPresent(String.self, forKey: .pay_id)
        vendor_shipping_id = try values.decodeIfPresent(String.self, forKey: .vendor_shipping_id)
        vendor_packing_id = try values.decodeIfPresent(String.self, forKey: .vendor_packing_id)
    }

}
