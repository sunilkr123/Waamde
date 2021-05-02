//
//  CreateAccount.swift
//  Waamde
//
//  Created by Apple on 29/01/21.
//

import UIKit

class CreateAccount: UITableViewController {

    @IBOutlet weak var txtfPassword: UITextField!
    @IBOutlet weak var txtfPhone: UITextField!
    @IBOutlet weak var txtfname: UITextField!
    @IBOutlet weak var txtfEmail: UITextField!
    var sigupVM = registerViewModel()
    var signupData = SignUpData()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtfname.delegate = self
        self.txtfPhone.delegate = self
        self.txtfEmail.delegate = self
        self.txtfPassword.delegate = self
        sigupVM.registerVMDelegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func btnCreateAccount(_ sender: Any) {
        validate()
    }
    func validate() {
        do {
            let _ = try  txtfEmail.validatedText(validationType: ValidatorType.email)
            let _ = try txtfPassword.validatedText(validationType: ValidatorType.password)
            let _ = try txtfname.validatedText(validationType: ValidatorType.firstName)
//            let _ = try txtfPhone.validatedText(validationType: ValidatorType.mobileNumber)
            //let loginData = LoginData(email: email, Password: password)
            self.sigupVM.callRegisterAPI(data: self.signupData)
        } catch(let error) {
            AlertManager.showAlertControllerWith(message: .custom((error as! ValidationError).message), controller: self, buttons: .ok(nil))
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CreateAccount: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        if textField == txtfEmail {
            signupData.email = text
        } else if textField == txtfPassword {
            signupData.Password = text
        }else if textField == txtfname {
            signupData.firstName = text
        }else if textField == txtfPhone {
            signupData.phoneNum = text
        }
        signupData.address = "Test"
//        if loginData.isAllValueEmpty() {
//            self.btnSignIn.isUserInteractionEnabled = false
//            self.btnSignIn.alpha = 0.5
//        } else {
//            self.btnSignIn.isUserInteractionEnabled = true
//            self.btnSignIn.alpha = 1
//        }
        if string.isEmpty {
            return true
        }
        
        if textField == txtfEmail {
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
extension CreateAccount: RegisterViewModelDelegate {
    
    func registerSuccess(message: String, userModel:UserModel) {
        self.txtfname.text = ""
        self.txtfPassword.text = ""
        self.txtfPhone.text = ""
        self.txtfEmail.text = ""
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.main, name: .roottab)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func registerFaiure(message: String) {
        AlertManager.showAlertControllerWith(message: .custom(message), controller: self, buttons: .ok(nil))
    }
    
  
    
}
