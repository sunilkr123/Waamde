

import Foundation
import SVProgressHUD

protocol UserDetailViewModelDelegate {
    func userdetailSuccess(message:String, userModel:UserModel)
    func userdetailFaiure(message:String)
   
}
extension UserDetailViewModelDelegate {
    func userdetailSuccess(message:String, userModel:UserModel){}
    func userdetailFaiure(message:String){}
    
}

class userdetailViewModel {
    
    var userdetailVMDelegate: UserDetailViewModelDelegate?
    
    
    func UpdateUserDetailAPI(user_id:String,name:String,email:String,phone:String) {
        SVProgressHUD.show()
        let userdetailParams = ["user_id":user_id,"token":AppDefaults.getToken(),"name":name,"email":email,"phone":phone]
        let userdetailUrl = BASE_URL.userupdate.urlString()
        WebManager.shared.requestPOSTURL(userdetailUrl, params: userdetailParams) { (result, error) in
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
                                //AppDefaults.setUserDetail(value: true)
                                AppDefaults.saveUser(user: userObj)
                                self.userdetailVMDelegate?.userdetailSuccess(message: "Profile Update Successfully", userModel: userObj)
                            } catch {
                                LogManager.printVariable(variable:error )
                            }
//                        } else {
//                            if let getMessage = result?[kMessage] as? String {
//                                self.userdetailVMDelegate?.userdetailFaiure(message: getMessage)
//                            }
//                        }
                    } else {
                        if let getMessage = result?[kMessage] as? String {
                            self.userdetailVMDelegate?.userdetailFaiure(message: getMessage)
                        }
                    }
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.userdetailVMDelegate?.userdetailFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
    
    func callUserDetailAPI(user_id:String) {
        SVProgressHUD.show()
        let userdetailParams = ["user_id":user_id,"token":AppDefaults.getToken()]
        let userdetailUrl = BASE_URL.userdetail.urlString()
        WebManager.shared.requestPOSTURL(userdetailUrl, params: userdetailParams) { (result, error) in
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
                                //AppDefaults.setUserDetail(value: true)
                                AppDefaults.saveUser(user: userObj)
                                self.userdetailVMDelegate?.userdetailSuccess(message: "", userModel: userObj)
                            } catch {
                                LogManager.printVariable(variable:error )
                            }
//                        } else {
//                            if let getMessage = result?[kMessage] as? String {
//                                self.userdetailVMDelegate?.userdetailFaiure(message: getMessage)
//                            }
//                        }
                    } else {
                        if let getMessage = result?[kMessage] as? String {
                            self.userdetailVMDelegate?.userdetailFaiure(message: getMessage)
                        }
                    }
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.userdetailVMDelegate?.userdetailFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
}
