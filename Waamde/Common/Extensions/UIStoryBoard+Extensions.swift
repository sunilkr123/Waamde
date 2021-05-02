

import Foundation
import UIKit

enum StoryBoardName : String {
    case main = "Main"
    case signUp = "SignUp"
    case storeDetail = "StoreDetail"
    case productDetail = "ProductDetail"
    case profile = "Profile"
}

enum ViewControllerName : String {
    case loginVc = "LoginVc"
    case forgotPassword = "ForgotPassword"
    case createAccount = "CreateAccount"
    case roottab = "roottab"
    case ConfirmShopping = "ConfirmShopping"
    case confirmationSuccess = "ConfirmationSuccess"
    case productDetail = "ProductDetail"
    case storeDetailVC = "StoreDetailVC"
    case reviewVc = "ReviewVc"
    case notificationVC = "NotificationVC"
    case orderVc = "OrderVc"
    case addressVc = "AddressVc"
    case changePasswordVC = "ChangePasswordVC"
    case editProfile = "EditProfile"
    case writeReviewVC = "WriteReviewVC"
    case ProductLIstVC = "ProductLIstVC"
    case OrderDetailVc = "OrderDetailVc"
}

enum ViewControllers {
    //Login Controllers
    case getStartedVC, loginVC, forgotPasswordVC, signUpVC, veriftyOTPVC, changeNumberVC, termsVC
    //Home Controllers
    case homeVC, tabBarVC, performanceVC, emailVerifyVC, bookReviewVC, manageReaderVC, selectAreaderVC, addReaderVC, startPracticeVC, congratulationsVC, readBooksVC, DeleteUserVC, PerformanceDetailVC
    case contactVC
    case preReadingVC, youGotItVC, spotOnVC, shareScreenVC, tryAgainVC, ReadingSessionVC,ResumeVC,EndSessionConfirmVC,ResultVC,CallViewController
    
    func vcString() -> String {
        switch self {
        case .DeleteUserVC:
            return "DeleteUserVC"
        case .tryAgainVC:
            return "TryAgainVC"
        case .shareScreenVC:
            return "ShareScreenVC"
        case .readBooksVC:
            return "ReadBooksVC"
        case .preReadingVC:
            return "PreReadingVC"
        case .getStartedVC:
            return "GetStartedVC"
        case .loginVC:
            return "LoginVC"
        case .forgotPasswordVC:
            return "ForgotPasswordVC"
        case .signUpVC:
            return "SignUpVC"
        case .veriftyOTPVC:
            return "VerifyOTPVC"
        case .changeNumberVC:
            return "ChangeNumberVC"
        case .homeVC:
            return "HomeVC"
        case .tabBarVC:
            return "TabBarVC"
        case .performanceVC:
            return "PerformanceVC"
        case .emailVerifyVC:
            return "EmailVerifyVC"
        case .termsVC:
            return "TermsAndConditionVC"
        case .bookReviewVC:
            return "BookReviewVC"
        case .manageReaderVC:
            return "ManageRederVC"
        case .selectAreaderVC:
            return "SelectAReaderVC"
        case .addReaderVC:
            return "AddANewReaderVC"
        case .startPracticeVC:
            return "StartPracticeVC"
        case .congratulationsVC:
            return "CongratulationVC"
        case .contactVC:
            return "ContactVC"
        case .youGotItVC:
            return "YouGotItVC"
        case .spotOnVC:
            return "SpotOnVC"
        case .PerformanceDetailVC:
            return "PerformanceDetailVC"
        case .ReadingSessionVC:
            return "ReadingSessionVC"
        case .ResumeVC:
            return "ResumeVC"
        case .EndSessionConfirmVC:
            return "EndSessionConfirmVC"
        case .ResultVC:
            return "ResultVC"
        case .CallViewController:
            return "CallViewController"
        }
    }
}
