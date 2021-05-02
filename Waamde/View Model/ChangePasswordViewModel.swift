

import Foundation
import SVProgressHUD

protocol ChangePasswordViewModelDelegate {
    func changepasswordSuccess(message:String, userModel:UserModel?)
    func changepasswordFaiure(message:String)
  
}
extension ChangePasswordViewModelDelegate {
    func changepasswordSuccess(message:String, userModel:UserModel?){}
    func changepasswordFaiure(message:String){}
}

class changepasswordViewModel {
    
    var changepasswordVMDelegate: ChangePasswordViewModelDelegate?
    
    
   
    
    func callChangePasswordAPI(password:String,confirm_password:String) {
        SVProgressHUD.show()
        let changepasswordParams = ["password":password,
                                    "confirm_password":confirm_password,"token":AppDefaults.getToken()]
        let changepasswordUrl = BASE_URL.changepassword.urlString()
        WebManager.shared.requestPOSTURL(changepasswordUrl, params: changepasswordParams) { (result, error) in
            SVProgressHUD.dismiss()
            if let getResult = result {
                if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                    self.changepasswordVMDelegate?.changepasswordSuccess(message: "", userModel: nil)
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.changepasswordVMDelegate?.changepasswordFaiure(message: getMessage)
                    }
                    
                    
                }
            } else {
                self.changepasswordVMDelegate?.changepasswordFaiure(message: "Please try again")
            }
        }
    }
}
