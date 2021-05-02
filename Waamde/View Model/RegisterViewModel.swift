

import Foundation
import SVProgressHUD

protocol RegisterViewModelDelegate {
    func registerSuccess(message:String, userModel:UserModel)
    func registerFaiure(message:String)
    
}
extension RegisterViewModelDelegate {
    func registerSuccess(message:String, userModel:UserModel){}
    func registerFaiure(message:String){}
    
}

class registerViewModel {
    
    var registerVMDelegate: RegisterViewModelDelegate?
    
    
    
    
    func callRegisterAPI(data:SignUpData) {
        SVProgressHUD.show()
        let loginParams = [kEmail:data.email,
                           kPassword:data.Password,kName:data.firstName,kPhone:data.phoneNum,kAddress:data.address]
        let loginUrl = BASE_URL.signUP.urlString()
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
                                AppDefaults.setLogin(value: true)
                                self.registerVMDelegate?.registerSuccess(message: "", userModel: userObj)
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
                            self.registerVMDelegate?.registerFaiure(message: getMessage)
                        }
                    }
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.registerVMDelegate?.registerFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
}
