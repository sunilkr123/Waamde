/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct UserDetail : Codable {
	let id : Int?
	let name : String?
	let photo : String?
	let zip : String?
	let city : String?
	let country : String?
	let address : String?
	let phone : String?
	let fax : String?
	let email : String?
	let created_at : String?
	let updated_at : String?
	let is_provider : String?
	let status : String?
	let verification_link : String?
	let email_verified : String?
	let affilate_code : String?
	let affilate_income : String?
	let shop_name : String?
	let owner_name : String?
	let shop_number : String?
	let shop_address : String?
	let reg_number : String?
	let shop_message : String?
	let shop_details : String?
	let shop_image : String?
	let f_url : String?
	let g_url : String?
	let t_url : String?
	let l_url : String?
	let is_vendor : String?
	let f_check : String?
	let g_check : String?
	let t_check : String?
	let l_check : String?
	let mail_sent : String?
	let shipping_cost : String?
	let current_balance : String?
	let date : String?
	let ban : String?
	let token : String?
	let device_type : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case photo = "photo"
		case zip = "zip"
		case city = "city"
		case country = "country"
		case address = "address"
		case phone = "phone"
		case fax = "fax"
		case email = "email"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case is_provider = "is_provider"
		case status = "status"
		case verification_link = "verification_link"
		case email_verified = "email_verified"
		case affilate_code = "affilate_code"
		case affilate_income = "affilate_income"
		case shop_name = "shop_name"
		case owner_name = "owner_name"
		case shop_number = "shop_number"
		case shop_address = "shop_address"
		case reg_number = "reg_number"
		case shop_message = "shop_message"
		case shop_details = "shop_details"
		case shop_image = "shop_image"
		case f_url = "f_url"
		case g_url = "g_url"
		case t_url = "t_url"
		case l_url = "l_url"
		case is_vendor = "is_vendor"
		case f_check = "f_check"
		case g_check = "g_check"
		case t_check = "t_check"
		case l_check = "l_check"
		case mail_sent = "mail_sent"
		case shipping_cost = "shipping_cost"
		case current_balance = "current_balance"
		case date = "date"
		case ban = "ban"
		case token = "token"
		case device_type = "device_type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		photo = try values.decodeIfPresent(String.self, forKey: .photo)
		zip = try values.decodeIfPresent(String.self, forKey: .zip)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		fax = try values.decodeIfPresent(String.self, forKey: .fax)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		is_provider = try values.decodeIfPresent(String.self, forKey: .is_provider)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		verification_link = try values.decodeIfPresent(String.self, forKey: .verification_link)
		email_verified = try values.decodeIfPresent(String.self, forKey: .email_verified)
		affilate_code = try values.decodeIfPresent(String.self, forKey: .affilate_code)
		affilate_income = try values.decodeIfPresent(String.self, forKey: .affilate_income)
		shop_name = try values.decodeIfPresent(String.self, forKey: .shop_name)
		owner_name = try values.decodeIfPresent(String.self, forKey: .owner_name)
		shop_number = try values.decodeIfPresent(String.self, forKey: .shop_number)
		shop_address = try values.decodeIfPresent(String.self, forKey: .shop_address)
		reg_number = try values.decodeIfPresent(String.self, forKey: .reg_number)
		shop_message = try values.decodeIfPresent(String.self, forKey: .shop_message)
		shop_details = try values.decodeIfPresent(String.self, forKey: .shop_details)
		shop_image = try values.decodeIfPresent(String.self, forKey: .shop_image)
		f_url = try values.decodeIfPresent(String.self, forKey: .f_url)
		g_url = try values.decodeIfPresent(String.self, forKey: .g_url)
		t_url = try values.decodeIfPresent(String.self, forKey: .t_url)
		l_url = try values.decodeIfPresent(String.self, forKey: .l_url)
		is_vendor = try values.decodeIfPresent(String.self, forKey: .is_vendor)
		f_check = try values.decodeIfPresent(String.self, forKey: .f_check)
		g_check = try values.decodeIfPresent(String.self, forKey: .g_check)
		t_check = try values.decodeIfPresent(String.self, forKey: .t_check)
		l_check = try values.decodeIfPresent(String.self, forKey: .l_check)
		mail_sent = try values.decodeIfPresent(String.self, forKey: .mail_sent)
		shipping_cost = try values.decodeIfPresent(String.self, forKey: .shipping_cost)
		current_balance = try values.decodeIfPresent(String.self, forKey: .current_balance)
		date = try values.decodeIfPresent(String.self, forKey: .date)
		ban = try values.decodeIfPresent(String.self, forKey: .ban)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		device_type = try values.decodeIfPresent(String.self, forKey: .device_type)
	}

}
