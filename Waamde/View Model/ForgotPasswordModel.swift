

import Foundation
import SVProgressHUD

protocol ForgotViewModelDelegate {
    func forgotSuccess(message:String, userModel:UserModel)
    func forgotFaiure(message:String)
    
}
extension ForgotViewModelDelegate {
    func forgotSuccess(message:String, userModel:UserModel){}
    func forgotFaiure(message:String){}
    
}

class forgotViewModel {
    
    var forgotVMDelegate: ForgotViewModelDelegate?
    
    
    
    
    func callForgotAPI(data:ForgotPasswordData) {
        SVProgressHUD.show()
        let loginParams = [kEmail:data.email]
        let loginUrl = BASE_URL.forgotPassword.urlString()
        WebManager.shared.requestPOSTURL(loginUrl, params: loginParams) { (result, error) in
            SVProgressHUD.dismiss()
            if let getResult = result {
                if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                    if let getData = getResult[kData] as? [String:Any] {
                        if let getToken = getData[kToken] as? String {
                            AppDefaults.saveToken(token: getToken)
                        }
//                        if let getUser = getData[kData] as? [String:Any] {
                            guard let resultObject = try? JSONSerialization.data(withJSONObject: getData, options: .prettyPrinted) else { return }
                            do {
                                let userObj = try JSONDecoder().decode(UserModel.self, from: resultObject)
                                AppDefaults.saveUser(user: userObj)
                                self.forgotVMDelegate?.forgotSuccess(message: "", userModel: userObj)
                            } catch {
                                LogManager.printVariable(variable:error )
                            }
//                        } else {
//                            if let getMessage = result?[kMessage] as? String {
//                                self.loginVMDelegate?.loginFaiure(message: getMessage)
//                            }
//                        }
                    } else {
                        if let getMessage = result?[kMessage] as? String {
                            self.forgotVMDelegate?.forgotFaiure(message: getMessage)
                        }
                    }
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.forgotVMDelegate?.forgotFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
}
