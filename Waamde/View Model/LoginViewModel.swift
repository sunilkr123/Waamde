

import Foundation
import SVProgressHUD

protocol LoginViewModelDelegate {
    func loginSuccess(message:String, userModel:UserModel)
    func loginFaiure(message:String)
    func socialSuccess(message:String, userModel:UserModel)
    func socialFailure(message:String)
}
extension LoginViewModelDelegate {
    func loginSuccess(message:String, userModel:UserModel){}
    func loginFaiure(message:String){}
    func socialSuccess(message:String, userModel:UserModel){}
    func socialFailure(message:String){}
}

class loginViewModel {
    
    var loginVMDelegate: LoginViewModelDelegate?
    
    
    func callSocialLoginAPI(data:SocialLoginData) {
        SVProgressHUD.show()
        let socialLoginParams = [kEmail:data.email,
                                 kFirstName:data.firstName,
                                 kLastName:data.lastname,
                                 kType:data.type] as [String:Any]
        let socialLoginUrl = BASE_URL.socialLogin.urlString()
        WebManager.shared.requestPOSTURL(socialLoginUrl, params: socialLoginParams) { (result, error) in
            SVProgressHUD.dismiss()
            if let getResult = result {
                if let getSuccess = result?[kSuccess] as? Int, getSuccess == 1 {
                    if let getData = getResult[kData] as? [String:Any] {
                        if let getToken = getData[kToken] as? String {
                            AppDefaults.saveToken(token: getToken)
                        }
                        if let getUser = getData[kUser] as? [String:Any] {
                            guard let resultObject = try? JSONSerialization.data(withJSONObject: getUser, options: .prettyPrinted) else { return }
                            do {
                                let userObj = try JSONDecoder().decode(UserModel.self, from: resultObject)
                                AppDefaults.setLogin(value: true)
                                AppDefaults.saveUser(user: userObj)
                                self.loginVMDelegate?.socialSuccess(message: "", userModel: userObj)
                            } catch {
                                LogManager.printVariable(variable:error )
                            }
                        } else {
                            if let getMessage = result?[kMessage] as? String {
                                self.loginVMDelegate?.socialFailure(message: getMessage)
                            }
                        }
                    } else {
                        if let getError = result?[kError] as? [[String:Any]] {
                            
                        }
                        if let getMessage = result?[kMessage] as? String {
                            self.loginVMDelegate?.socialFailure(message: getMessage)
                        }
                    }
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.loginVMDelegate?.loginFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
    
    func callLoginAPI(data:LoginData) {
        SVProgressHUD.show()
        let loginParams = [kEmail:data.email,
                           kPassword:data.Password]
        let loginUrl = BASE_URL.login.urlString()
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
                                AppDefaults.setLogin(value: true)
                                AppDefaults.saveUser(user: userObj)
                                self.loginVMDelegate?.loginSuccess(message: "", userModel: userObj)
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
                            self.loginVMDelegate?.loginFaiure(message: getMessage)
                        }
                    }
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.loginVMDelegate?.loginFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
}
