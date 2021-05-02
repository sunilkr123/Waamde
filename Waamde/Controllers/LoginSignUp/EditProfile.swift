//
//  EditProfile.swift
//  Waamde
//
//  Created by Apple on 31/01/21.
//

import UIKit

class EditProfile: UITableViewController,UserDetailViewModelDelegate {

    @IBOutlet weak var txtfPhone: UITextField!
    @IBOutlet weak var txtfEmail: UITextField!
    @IBOutlet weak var txtfName: UITextField!
    var editProfileVm = userdetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        editProfileVm.userdetailVMDelegate = self
        if let user = AppDefaults.loadCurrentUser(){
            txtfName.text = user.name
            txtfPhone.text = user.phone
            txtfEmail.text = user.email
        }
       
    }
    func userdetailSuccess(message: String, userModel: UserModel) {
        DesignManager.showAlertWithTitle("Alert", message: message, viewController: self)
    }
    func userdetailFaiure(message: String) {
        DesignManager.showAlertWithTitle("Alert", message: message, viewController: self)
    }
    @IBAction func btnBack(_ sender: Any) {
           self.dismiss(animated: true, completion: nil)
       }

    @IBAction func btnUpdateProfile(_ sender: Any) {
        editProfileVm.UpdateUserDetailAPI(user_id: "\(AppDefaults.loadCurrentUser()?.id ?? 0)", name: txtfName.text ?? "", email: txtfEmail.text ?? "", phone: txtfPhone.text ?? "")
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
