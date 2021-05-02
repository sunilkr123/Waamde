

import Foundation

class ValidationManager: NSObject {
    class func isValidEmail(_ email:String)-> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
}

class ValidationError: Error {
    var message: String
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
    func validated(_ value:Bool) throws -> String
}

extension ValidatorConvertible {
    func validated(_ value:Bool) throws -> String {return ""}
    func validated(_ value: String) throws -> String{return ""}
}

enum ValidatorType {
    case email
    case password
    case firstName
    case lastName
    case mobileNumber
    case city
    case state
    case dob
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        case .firstName: return FirstNameValidator()
        case .lastName: return LastNameValidator()
        case .mobileNumber: return MobileNumberValidator()
        case .city: return CityValidator()
        case .state: return StateValidator()
        case .dob: return DobValidator()
        }
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError(ValidatorMessages.kEmptyEmail)}
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError(ValidatorMessages.kInvalidEmail)
            }
        } catch {
            throw ValidationError(ValidatorMessages.kInvalidEmail)
        }
        return value
    }
}

struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError(ValidatorMessages.kEmptyPassword)}
        guard value.count >= 6 else { throw ValidationError(ValidatorMessages.kPasswordRange) }
        return value
    }
}

struct FirstNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError(ValidatorMessages.kFirstName)}
        return value
    }
}
struct CityValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError(ValidatorMessages.kCityName)}
        return value
    }
}
struct StateValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError(ValidatorMessages.kStateName)}
        return value
    }
}
struct DobValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError(ValidatorMessages.kDob)}
        return value
    }
}

struct LastNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError(ValidatorMessages.kLastName)}
        return value
    }
}

struct MobileNumberValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError(ValidatorMessages.kEmptyPhone)}
        do {
            if try NSRegularExpression(pattern: "^\\d{4} \\d{3} \\d{3}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError(ValidatorMessages.kinvalidNumber)
            }
        } catch {
            throw ValidationError(ValidatorMessages.kinvalidNumber)
        }
        let phoneNumber = value.replacingOccurrences(of: " ", with: "")
        return phoneNumber
    }
    
}
