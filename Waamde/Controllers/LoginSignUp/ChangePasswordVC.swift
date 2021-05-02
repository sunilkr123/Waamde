//
//  ChangePasswordVC.swift
//  Waamde
//
//  Created by Apple on 30/01/21.
//

import UIKit

class ChangePasswordVC: UITableViewController,ChangePasswordViewModelDelegate {
    @IBOutlet weak var txtfConfirmPass: UITextField!
    
    @IBOutlet weak var txtfNewpassword: UITextField!
    @IBOutlet weak var txtfOldPassword: UITextField!
var changeVm = changepasswordViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        changeVm.changepasswordVMDelegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBack(_ sender: Any) {
              self.dismiss(animated: true, completion: nil)
          }

    @IBAction func btnChangePassword(_ sender: Any) {
        if((txtfOldPassword.text?.count ?? 0) > 0 && (txtfNewpassword.text?.count ?? 0) > 0 && (txtfConfirmPass.text?.count ?? 0) > 0){
            changeVm.callChangePasswordAPI(password: txtfNewpassword.text ?? "", confirm_password: txtfConfirmPass.text ?? "")
        }
    }
    func changepasswordSuccess(message: String, userModel: UserModel?) {
        DesignManager.showAlertWithTitle("Alert", message: "Password change successfully", viewController: self)
        self.dismiss(animated: true, completion: nil)
    }
    func changepasswordFaiure(message: String) {
        DesignManager.showAlertWithTitle("Alert", message: message, viewController: self)
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
