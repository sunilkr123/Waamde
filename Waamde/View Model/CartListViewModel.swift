

import Foundation
import SVProgressHUD

protocol CartListViewModelDelegate {
    func CartListSuccess(message:String, userModel:[CartListModel])
    func CartListFaiure(message:String)
    
}
extension CartListViewModelDelegate {
    func CartListSuccess(message:String, userModel:[CartListModel]){}
    func CartListFaiure(message:String){}
   
}

class CartListViewModel {
    
    var cartListVMDelegate: CartListViewModelDelegate?
    
    
    func callCartListApi(category_id:String,user_id:String) {
        SVProgressHUD.show()
        let socialLoginParams = ["user_id":user_id] as [String:Any]
        let socialLoginUrl = BASE_URL.cartlist.urlString()
        WebManager.shared.requestPOSTURL(socialLoginUrl, params: socialLoginParams) { (result, error) in
            SVProgressHUD.dismiss()
            if let getResult = result {
                if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                    if let getData = getResult[kData] as? [[String:Any]] {
                       
                        if let getUser = getResult[kData] as? [[String:Any]] {
                            guard let resultObject = try? JSONSerialization.data(withJSONObject: getUser, options: .prettyPrinted) else { return }
                            do {
                                let userObj = try JSONDecoder().decode(Array<CartListModel>.self, from: resultObject)
                                //AppDefaults.saveUser(user: userObj)
                                self.cartListVMDelegate?.CartListSuccess(message: "", userModel: userObj)
                            } catch {
                                LogManager.printVariable(variable:error )
                            }
                        } else {
                            if let getMessage = result?[kMessage] as? String {
                                self.cartListVMDelegate?.CartListFaiure(message: getMessage)
                            }
                        }
                    } else {
                        if let getError = result?[kError] as? [[String:Any]] {
                            
                        }
                        if let getMessage = result?[kMessage] as? String {
                            self.cartListVMDelegate?.CartListFaiure(message: getMessage)
                        }
                    }
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.cartListVMDelegate?.CartListFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
    func SearchCartListApi(category_id:String,user_id:String,product_name:String,min_price:String,maxPrice:String) {
        SVProgressHUD.show()
        let socialLoginParams = ["category_id":category_id,"product_name":product_name] as [String:Any]
        let socialLoginUrl = BASE_URL.search.urlString()
        WebManager.shared.requestPOSTURL(socialLoginUrl, params: socialLoginParams) { (result, error) in
            SVProgressHUD.dismiss()
            if let getResult = result {
                if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                    if let getData = getResult[kData] as? [[String:Any]] {
                       
                        if let getUser = getResult[kData] as? [[String:Any]] {
                            guard let resultObject = try? JSONSerialization.data(withJSONObject: getUser, options: .prettyPrinted) else { return }
                            do {
                                let userObj = try JSONDecoder().decode(Array<CartListModel>.self, from: resultObject)
                                //AppDefaults.saveUser(user: userObj)
                                self.cartListVMDelegate?.CartListSuccess(message: "", userModel: userObj)
                            } catch {
                                LogManager.printVariable(variable:error )
                            }
                        } else {
                            if let getMessage = result?[kMessage] as? String {
                                self.cartListVMDelegate?.CartListFaiure(message: getMessage)
                            }
                        }
                    } else {
                        if let getError = result?[kError] as? [[String:Any]] {
                            
                        }
                        if let getMessage = result?[kMessage] as? String {
                            self.cartListVMDelegate?.CartListFaiure(message: getMessage)
                        }
                    }
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.cartListVMDelegate?.CartListFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
   
}
