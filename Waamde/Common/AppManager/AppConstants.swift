

import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let appDelegateShared = UIApplication.shared

struct Appconstants {
    static let kSignIn = "Sign In"
    static let kAlreadyARegisterUser = "Already a registered user? "
    static let KDontReceiveACode = "Don’t receive a verification code?\n"
    static let kChangeNumber = "Change Number "
    static let kResend = "| Resend"
    static let kEnterFourDitigOTPText = "Enter 4 Digit OTP sent you at\n%@"
    static let kAddedSuccessfully = "%@ added successfully!"
    static let kDeleteUser = "Are you sure, you want to delete"
    static let kTryAgain = "Please try again later"
    static let kAccountActivation = "Account activation pending. verify your email now"
    static let kNoReaders = "No Readers found"
}

struct CellIdentifiers {
    static let manageTVC = "ManageTVC"
    static let addNewReaderTVC = "AddNewReaderTVC"
    static let contactTVC = "ContactTVC"
    static let performanceTVC = "PerformanceTVC"
    static let readBookTVC = "ReadBookTVC"
    static let PerformanceDetailTVC = "PerformanceDetailTVC"
    static let homeCollectionViewCell = "HomeCollectionViewCell"
}

struct ImageConstant {
    static let kTempConstant = "tempPlaceholder"
    static let kgroup5Copy3 = "group5Copy3"
    static let kHome = "home"
    static let kBookList = "booklist"
    static let kContact = "contact"
    static let kPerformance = "performance"
    static let kHomeS = "homeS"
    static let kBookListS = "booklistS"
    static let kContactS = "contactS"
    static let kPerformanceS = "performanceS"
    static let kDisableMic = "disablemic"
    static let kEnableMic = "technology9"
}

struct ColorConstant {
    static let kDarkBlue = "DarkBlue"
    static let kBookShadowColor = "BooksShadowColor"
}

struct UserDefaultConstant {
    static let kUser = "appUser"
    static let kToken = "appToken"
    static let kIsLogin = "isLogin"
    static let kAccessToken = "accessToken"
    static let kRefreshToken = "refreshToken"
}

struct ValidatorMessages {
    static let kEmptyEmail = "Email field cannot be empty"
    static let kInvalidEmail = "Please enter valid Email"//"Email is invalid"
    static let kEmptyPassword = "Password field cannot be empty"
    static let kPasswordRange = "Please Enter password between 6-12 Characters"//"Password must be of greater than 8 Characters"
    static let kPasswordType = "Password must be of alphanumeric"
    static let kFirstName = "Please enter first name"
    static let kLastName = "Please enter last name"
    static let kEmptyPhone = "Please enter mobile number"
    static let kinvalidNumber = "Please enter valid Phone number"//"Please enter valid number"
    static let kTermsAndCondition = "Please accept Terms and conditions"
    static let kEnterOTP = "Please enter OTP"
    static let kValidOTP = "Please enter valid OTP"
    static let kCityName = "Please enter city name"
    static let kStateName = "Please enter state name"
    static let kDob = "Please enter date of birth"
}

struct PlaceHolderValues {
    static let kpassword = "Password"
    static let KEmailAddress = "Email Address"
}

struct ContactConstant {
    static let contact_emails = "contact_emails"
    static let contact_name = "contact_name"
    static let contact_numbers = "contact_numbers"
    static let contact_id = "contact_id"
    static let contacts = "contacts"
}

struct PerformConstant {
    static let book_read = "Books Read - "
    static let book_read_time = "Reading Time - "
    static let reading_accuracy = "Reading Accuracy - "
    static let contact_numbers = "contact_numbers"
    static let word_read = "Words Read - "
    static let error_count = "Error Count - "
    static let blank_list = "Readers performance will appear here"
    static let performance = "Performance"
    static let newDate = "new Date"
}

let kChooseImage = "Choose Image"
let kCamera = "Camera"
let kGallery = "Gallery"
let kCancel = "Cancel"
let kWarning = "Warning"
let kYouDontHaveCamera = "You don't have camera"
let kOk = "Ok"
let kDone = "Done"
let kGB = "GB"
let kGoogleScopeBooks = "https://www.googleapis.com/auth/books"
let googleError = "The user has not signed in before or they have since signed out."
let kHowAreYou = "Say \"How are you?\""
let kYouGotItRight = "You Got It right"
let kSayItAgain = "Say it Again"
let kSayHello = "Say \"Hello\""
let kHowAreYouOnly = "How are you"
let kAudioType = "audio/ogg;codecs=opus"
let kHello = "Hello"
let kPlaceholderImage = "user_icon"
let kDateformat = "yyyy-MM-dd"

struct GraphType {
    static let day = "Day"
    static let week = "Week"
    static let month = "Month"
    static let year = "Year"
}

struct LoginConstant {
    static let notSatisfyingDeviceToken = "Invalid parameter not satisfying: deviceToken != nil"
    static let enterToChat = NSLocalizedString("Enter to Video Chat", comment: "")
    static let fullNameDidChange = NSLocalizedString("Full Name Did Change", comment: "")
    static let login = NSLocalizedString("Login", comment: "")
    static let checkInternet = NSLocalizedString("Please check your Internet connection", comment: "")
    static let enterUsername = NSLocalizedString("Please enter your login and Display Name.", comment: "")
    static let shouldContainAlphanumeric = NSLocalizedString("Field should contain alphanumeric characters only in a range 3 to 20. The first character must be a letter.", comment: "")
    static let shouldContainAlphanumericWithoutSpace = NSLocalizedString("Field should contain alphanumeric characters only in a range 8 to 15, without space. The first character must be a letter.", comment: "")
    static let showUsers = "ShowUsersViewController"
    static let defaultPassword = "quickblox"
    static let infoSegue = "ShowInfoScreen"
    static let chatServiceDomain = "com.q-municate.chatservice"
    static let errorDomaimCode = -1000
}

enum ErrorDomain: UInt {
    case signUp
    case logIn
    case logOut
    case chat
}

struct UsersAlertConstant {
    static let checkInternet = NSLocalizedString("Please check your Internet connection", comment: "")
    static let okAction = NSLocalizedString("Ok", comment: "")
    static let shouldLogin = NSLocalizedString("You should login to use VideoChat API. Session hasn’t been created. Please try to relogin.", comment: "")
    static let logout = NSLocalizedString("Logout...", comment: "")
}

struct UsersConstant {
    static let answerInterval: TimeInterval = 10.0
    static let pageSize: UInt = 50
    static let aps = "aps"
    static let alert = "alert"
    static let voipEvent = "VOIPCall"
}
