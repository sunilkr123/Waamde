

import Foundation
import SVProgressHUD

protocol AddCartViewModelDelegate {
    func AddCartSuccess(message:String, userModel:AddCartModel?)
    func AddCartFaiure(message:String)
    
}
extension AddCartViewModelDelegate {
    func AddCartSuccess(message:String, userModel:AddCartModel?){}
    func AddCartFaiure(message:String){}
    
}

class AddCartViewModel {
    
    var addCartVMDelegate: AddCartViewModelDelegate?
    
    
    func callAddCartApi(product_id:String,user_id:String,quantity:Int,color:String) {
        SVProgressHUD.show()
        let socialLoginParams = ["product_id":product_id,"user_id":user_id,"quantity":quantity,"color":color] as [String:Any]
        let socialLoginUrl = BASE_URL.add_cart.urlString()
        WebManager.shared.requestPOSTURL(socialLoginUrl, params: socialLoginParams) { (result, error) in
            SVProgressHUD.dismiss()
            if let getResult = result {
                if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                    if let getData = getResult[kData] as? [String:Any] {
                        
                        if let getUser = getResult[kData] as? [String:Any] {
                            guard let resultObject = try? JSONSerialization.data(withJSONObject: getUser, options: .prettyPrinted) else { return }
                            do {
                                let userObj = try JSONDecoder().decode(AddCartModel.self, from: resultObject)
                                //AppDefaults.saveUser(user: userObj)
                                if let getMessage = result?[kMessage] as? String {
                                    self.addCartVMDelegate?.AddCartSuccess(message: getMessage, userModel: userObj)
                                }
                                
                            } catch {
                                LogManager.printVariable(variable:error )
                            }
                        } else {
                            if let getMessage = result?[kMessage] as? String {
                                self.addCartVMDelegate?.AddCartFaiure(message: getMessage)
                            }
                        }
                    } else {
                        if let getError = result?[kError] as? [[String:Any]] {
                            
                        }
                        if let getMessage = result?[kMessage] as? String {
                            self.addCartVMDelegate?.AddCartFaiure(message: getMessage)
                        }
                    }
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.addCartVMDelegate?.AddCartFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
    
    func RemoveAddCartApi(product_id:String,user_id:String) {
        SVProgressHUD.show()
        let socialLoginParams = ["product_id":product_id,"user_id":user_id,"status":"delete"] as [String:Any]
        let socialLoginUrl = BASE_URL.add_cart.urlString()
        WebManager.shared.requestPOSTURL(socialLoginUrl, params: socialLoginParams) { (result, error) in
            SVProgressHUD.dismiss()
            if let getResult = result {
                if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                    self.addCartVMDelegate?.AddCartSuccess(message: "", userModel: nil)
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.addCartVMDelegate?.AddCartFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
}
