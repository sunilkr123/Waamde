//
//  ForgotPassword.swift
//  Waamde
//
//  Created by Apple on 30/01/21.
//

import UIKit
import SVProgressHUD
class ForgotPassword: UITableViewController {
    @IBOutlet weak var txtEmail: UITextField!
    var forgotVMDelegate:ForgotViewModelDelegate?
    @IBOutlet weak var btnSignIn: UIButton!
    var forgotData = ForgotPasswordData()
    var forgotVm = forgotViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.delegate = self
        self.forgotVm.forgotVMDelegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func validate() {
        do {
            let _ = try  txtEmail.validatedText(validationType: ValidatorType.email)
            
//            let _ = try txtfPhone.validatedText(validationType: ValidatorType.mobileNumber)
            //let loginData = LoginData(email: email, Password: password)
            self.forgotVm.callForgotAPI(data: forgotData)
        } catch(let error) {
            AlertManager.showAlertControllerWith(message: .custom((error as! ValidationError).message), controller: self, buttons: .ok(nil))
        }
    }
    @IBAction func btnSendLink(_ sender: Any) {
        validate()
    }
    func callForgotApi(data:ForgotPasswordData) {
        SVProgressHUD.show()
        let loginParams = [kEmail:data.email]
        let loginUrl = BASE_URL.forgotPassword
            .urlString()
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ForgotPassword: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        if textField == txtEmail {
            forgotData.email = text
        }
        if forgotData.isAllValueEmptyForForgot() {
            self.btnSignIn.isUserInteractionEnabled = false
            self.btnSignIn.alpha = 0.5
        } else {
            self.btnSignIn.isUserInteractionEnabled = true
            self.btnSignIn.alpha = 1
        }
        if string.isEmpty {
            return true
        }
        
        if textField == txtEmail {
            if let count = textField.text?.count, count >= 50 {
                return false
            }
        } else {
            if let count = textField.text?.count, count >= 12 {
                return false
            }
        }
        return true
    }
}
extension ForgotPassword: ForgotViewModelDelegate {
    
    func forgotSuccess(message: String, userModel:UserModel) {
        self.txtEmail.text = ""
        
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.main, name: .roottab)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func forgotFaiure(message: String) {
        AlertManager.showAlertControllerWith(message: .custom(message), controller: self, buttons: .ok(nil))
    }
    
    
    
}
