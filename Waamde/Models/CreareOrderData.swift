/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct CreareOrderData : Codable {
	let user_id : String?
	let cart : String?
	let order_type : String?
	let customer_email : String?
	let customer_name : String?
	let customer_phone : String?
	let pay_amount : String?
	let txnid : String?
	let updated_at : String?
	let created_at : String?
	let id : Int?

	enum CodingKeys: String, CodingKey {

		case user_id = "user_id"
		case cart = "cart"
		case order_type = "order_type"
		case customer_email = "customer_email"
		case customer_name = "customer_name"
		case customer_phone = "customer_phone"
		case pay_amount = "pay_amount"
		case txnid = "txnid"
		case updated_at = "updated_at"
		case created_at = "created_at"
		case id = "id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
		cart = try values.decodeIfPresent(String.self, forKey: .cart)
		order_type = try values.decodeIfPresent(String.self, forKey: .order_type)
		customer_email = try values.decodeIfPresent(String.self, forKey: .customer_email)
		customer_name = try values.decodeIfPresent(String.self, forKey: .customer_name)
		customer_phone = try values.decodeIfPresent(String.self, forKey: .customer_phone)
		pay_amount = try values.decodeIfPresent(String.self, forKey: .pay_amount)
		txnid = try values.decodeIfPresent(String.self, forKey: .txnid)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
	}

}
