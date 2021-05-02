//
//  LoginVc.swift
//  Waamde
//
//  Created by Apple on 29/01/21.
//

import UIKit

class LoginVc: UITableViewController {

    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var viewTwitter: UIView!
    @IBOutlet weak var viewGoogle: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    
    var loginVM = loginViewModel()
    var loginData = LoginData()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewGoogle.layer.borderWidth = 1
        viewTwitter.layer.borderWidth = 1
        viewGoogle.layer.borderColor = UIColor.UIColorFromRGB(rgbValue: 0x576DCA).cgColor
        viewTwitter.layer.borderColor = UIColor.UIColorFromRGB(rgbValue: 0x576DCA).cgColor
        txtEmail.delegate = self
        txtPassword.delegate = self
        self.loginVM.loginVMDelegate = self
        // Do any additional setup after loading the view.
    }
    
    func validate() {
        do {
            let email = try  txtEmail.validatedText(validationType: ValidatorType.email)
            let password = try txtPassword.validatedText(validationType: ValidatorType.password)
             loginData = LoginData(email: email, Password: password)
            self.loginVM.callLoginAPI(data: self.loginData)
        } catch(let error) {
            AlertManager.showAlertControllerWith(message: .custom((error as! ValidationError).message), controller: self, buttons: .ok(nil))
        }
    }
    @IBAction func btnSkip(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        goToHomeScreen()
    }
    
    @IBAction func btnForgot(_ sender: Any) {
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.signUp, name: .forgotPassword) as! ForgotPassword
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnCreateAccount(_ sender: Any) {
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.signUp, name: .createAccount) as! CreateAccount
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnLogin(_ sender: Any) {
        self.validate()
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
// MARK: UITextField Delegate
extension LoginVc: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        if textField == txtEmail {
            loginData.email = text
        } else if textField == txtPassword {
            loginData.Password = text
        }
        if loginData.isAllValueEmpty() {
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

extension LoginVc: LoginViewModelDelegate {
    
    func loginSuccess(message: String, userModel:UserModel) {
        self.txtEmail.text = ""
        self.txtPassword.text = ""
       goToHomeScreen()
    }
    
    func loginFaiure(message: String) {
        AlertManager.showAlertControllerWith(message: .custom(message), controller: self, buttons: .ok(nil))
    }
    
    func socialSuccess(message:String, userModel:UserModel){
                let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.main, name: .roottab)
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
    }
    
    func socialFailure(message:String){
        AlertManager.showAlertControllerWith(message: .custom(message), controller: self, buttons: .ok(nil))
    }
    
    func goToHomeScreen()  {
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.main, name: .roottab)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
