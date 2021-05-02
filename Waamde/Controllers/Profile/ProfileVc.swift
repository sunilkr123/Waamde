//
//  ProfileVc.swift
//  Waamde
//
//  Created by Apple on 30/01/21.
//

import UIKit

class ProfileVc: UIViewController {
    @IBOutlet weak var imgvLogo: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewCamera: UIView!
    var imagePicker: ImagePickers!
    var arrData = [catalogData]()
    
    @IBOutlet weak var tblvData: UITableView!
    let profileviewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = AppDefaults.loadCurrentUser(){
            let imageUrl = kBaseImageUrl+(user.photo ?? "")
            imgvLogo.sd_setImage(with: URL(string: imageUrl)) { (image, error, res, url) in
                if error == nil{
                    
                }else{
                    self.imgvLogo.image = UIImage(named:"waamde copy")
                }
            }
            lblName.text = user.name
        }
        if let isLogIn = AppDefaults.isLogin(), isLogIn {
            arrData.append(catalogData(image: "casual-t-shirt-", name: "Notifications"))
            arrData.append(catalogData(image: "casual-t-shirt-", name: "My orders"))
            arrData.append(catalogData(image: "casual-t-shirt-", name: "Addresses"))
            arrData.append(catalogData(image: "casual-t-shirt-", name: "Payment"))
            arrData.append(catalogData(image: "casual-t-shirt-", name: "Wishlist"))
            arrData.append(catalogData(image: "casual-t-shirt-", name: "Change Password"))
            
            arrData.append(catalogData(image: "casual-t-shirt-", name: "Edit Profile"))
            arrData.append(catalogData(image: "casual-t-shirt-", name: "Logout"))
        } else {
            arrData.append(catalogData(image: "casual-t-shirt-", name: "Login"))
        }
        viewCamera.layer.cornerRadius = viewCamera.frame.height/2
        self.imagePicker = ImagePickers(presentationController: self, delegate: self)
        managegestUser()
        profileviewModel.delegate = self
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnActionChangeProfilePic(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    
    
    
}
//MARK:-Profile Image update
extension ProfileVc:profileViewModelDelegate{
    func updateProfiledSuccess(message: String, userModel: UserModel?) {
        AlertManager.showAlertControllerWith(message: .custom(message), controller: self, buttons: .ok(nil))
    }
    
    func updateProfileFaiure(message: String) {
      AlertManager.showAlertControllerWith(message: .custom(message), controller: self, buttons: .ok(nil))
    }
    
    
    
}
//MARK:- ImagePicker Controller Delegates-
extension ProfileVc: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if let image = image {
            self.imgvLogo.image = image
            if let user = AppDefaults.loadCurrentUser(){
                self.profileviewModel.callApiToUpdateProfile(user_id:"\(user.id ?? 0)", email: user.email ?? "", imageName: "photo", image: self.imgvLogo.image!)
            }
            
        }
    }
}
extension ProfileVc:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("catalogCell", owner: self, options: nil)?[0] as! catalogCell
        cell.lblData.text = arrData[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let isLogIn = AppDefaults.isLogin(), isLogIn {
            if indexPath.row == 0{
                let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.profile, name: .notificationVC) as! NotificationVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            if indexPath.row == 1{
                let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.profile, name: .orderVc) as! OrderVc
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            if indexPath.row == 2{
                let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.storeDetail, name: .addressVc) as! AddressVc
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            if indexPath.row == 3{
                
            }
            if indexPath.row == 4{//wishlist
                self.tabBarController?.selectedIndex = 2
            }
            if indexPath.row == 5{
                let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.signUp, name: .changePasswordVC) as! ChangePasswordVC
                vc.modalPresentationStyle = .fullScreen
                
                self.present(vc, animated: true, completion: nil)
            }
            if indexPath.row == 6{
                let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.signUp, name: .editProfile) as! EditProfile
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            if indexPath.row == 7{
                let alert = UIAlertController(title: "Alert", message: "Are you sure you want to logout", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                    let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.main, name: .loginVc) as! LoginVc
                    vc.modalPresentationStyle = .fullScreen
                   self.present(vc, animated: true) {
                        AppDefaults.removeUser()
                        AppDefaults.removeToken()
                    AppDefaults.setLogin(value:false)
                    }
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action) in
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.main, name: .loginVc) as! LoginVc
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    func managegestUser(){
        if let isLogIn = AppDefaults.isLogin(), isLogIn {
            viewCamera.isHidden = false
        }else{
            viewCamera.isHidden = true
        }
        
    }
}
