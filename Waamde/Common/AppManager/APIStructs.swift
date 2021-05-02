

import Foundation

struct LoginData {
    var email = ""
    var Password = ""
    
    func isAllValueEmpty() -> Bool {
        if ValidationManager.isValidEmail(email) && Password.count >= 6 {
            return false
        } else {
            return true
        }
    }
}

struct ForgotPasswordData {
    var email:String = ""
    func isAllValueEmptyForForgot() -> Bool {
        if email.count > 0 {
            return false
        } else {
            return true
        }
    }
}



struct SignUpData {
    var email = ""
    var Password = ""
    var firstName = ""
    var lastName = ""
    var phoneNum = ""
    var countryCode = ""
    var address = ""
    func isAllValueEmptyForSocialSignup() -> Bool {
        if email.count > 0 , firstName.count > 0 , lastName.count > 0 , phoneNum.count > 0 {
            return false
        } else {
            return true
        }
    }
    
    func isAllValueEmptyForNormalSignUp() -> Bool {
        if email.count > 0 , firstName.count > 0 , lastName.count > 0 , phoneNum.count > 0, Password.count > 0 {
            return false
        } else {
            return true
        }
    }
}

struct ChangeNumberData {
    var userId:String
    var phoneNum:String
    var countryCode:String
}

struct SocialLoginData {
    var firstName = ""
    var lastname = ""
    var email = ""
    var phoneNum = ""
    var countryCode = ""
    var type = 0
}
struct ProductDetailData {
    var product_id = ""
    
}
struct OrderData {
    var user_id = ""
    var token = ""
    
}
struct AddReaderData {
    var firstName = ""
    var lastName = ""
    var email = ""
    var city = ""
    var state = ""
    var dob = 0.0
    var image = ""
    
    func isAllValueEmpty() -> Bool {
        if email.count > 0 , firstName.count > 0 , lastName.count > 0 , city.count > 0, state.count > 0 , dob > 0 {
            return false
        } else {
            return true
        }
    }
}

struct OTPData {
    var firstTF = ""
    var secTF = ""
    var thirdTF = ""
    var fourthTF = ""
    func getCode() -> String {
        return  firstTF + secTF + thirdTF + fourthTF
    }
}
