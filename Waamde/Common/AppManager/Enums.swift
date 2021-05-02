

import Foundation
import UIKit
public enum BASE_URL {
    case login, forgotPassword, signUP, verifyPhone(otp:Int,userId:Int), changeNumber, resendOTP, socialLogin
    case logout, getCategory, home, wishList, addReader, deleteReader, bookDetail(id:Int)
    case storeContact, getContacts, updatePracticeSession, getPerformance, graph_data, comparison_graph, read_books,get_access_token,add_page_data,get_page_data,end_session,invite_user,store_call_details,product_details,order_list,productlist,search,add_cart,cartlist,addwishlist,userdetail,changepassword,userupdate,createOrder,orderDetail
    
    func urlString() -> String {
        switch self {
        case .updatePracticeSession:
            return kBaseUrl + "update-practice-session"
        case .login:
            return kBaseUrl + "app-login"
        case .forgotPassword:
            return kBaseUrl + "forgot-password"
        case .signUP:
            return kBaseUrl + "app-registration"
        case .verifyPhone(let otp, let userID):
            return kBaseUrl + "verify-phone/\(otp)/\(userID)"
        case .changeNumber:
            return kBaseUrl + "change-number"
        case .resendOTP:
            return kBaseUrl + "resend-otp"
        case .socialLogin:
            return kBaseUrl + "social-login"
        case .logout:
            return kBaseUrl + "logout"
        case .getCategory:
            return kBaseUrl + "get-categories"
        case .home:
            return kBaseUrl + "home"
        case .wishList:
            return kBaseUrl + "wishlist-list"
        case .addReader:
            return kBaseUrl + "add-reader"
        case .deleteReader:
            return kBaseUrl + "delete-reader"
        case .bookDetail(let id):
            return kBaseUrl + "book-detail/\(id)"
        case .storeContact:
            return kBaseUrl + "store-contacts"
        case .getContacts:
            return kBaseUrl + "get-contacts"
        case .getPerformance:
            return kBaseUrl + "get-performance/"
        case .graph_data:
            return kBaseUrl + "graph-data"
        case .comparison_graph:
            return kBaseUrl + "comparison-graph"
        case .read_books:
               return kBaseUrl + "read-books?page="
        case .get_access_token:
            return kBaseUrl + "get-access-token"
        case .add_page_data:
            return kBaseUrl + "add-page-data"
        case .get_page_data:
            return kBaseUrl + "get-page-data/"
        case .end_session:
            return kBaseUrl + "end-session"
        case .invite_user:
            return kBaseUrl + "invite-user"
        case .store_call_details:
            return kBaseUrl + "store-call-details"
        case .product_details:
            return kBaseUrl + "product-details"
        case .order_list:
            return kBaseUrl + "order-list"
        case .productlist:
            return kBaseUrl + "product"
        case .search:
            return kBaseUrl + "search"
        case .add_cart:
            return kBaseUrl + "add-cart"
        case .cartlist:
        return kBaseUrl + "cartlist"
        case .addwishlist:
            return kBaseUrl + "add-wishlist"
        case .userdetail:
            return kBaseUrl + "user-detail"
        case .changepassword:
            return kBaseUrl + "change-password"
        case .userupdate:
            return kBaseUrl + "user-update"
        case .orderDetail:
            return kBaseUrl + "order-details"
        case .createOrder:
            return kBaseUrl + "create-order"
        }
    }
}

enum ScreenSize {
    case width
    case height
    
    func getValues() -> CGFloat {
        switch self {
        case .width:
            return UIScreen.main.bounds.width
        case .height:
            return UIScreen.main.bounds.height
        }
    }
}
