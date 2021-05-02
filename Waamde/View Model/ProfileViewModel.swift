//
//  ProfileViewModel.swift
//  Waamde
//
//  Created by mac on 03/05/21.
//
import UIKit
import Foundation
import SVProgressHUD

protocol profileViewModelDelegate {
    func updateProfiledSuccess(message:String, userModel:UserModel?)
    func updateProfileFaiure(message:String)
}

class ProfileViewModel {
    var delegate : profileViewModelDelegate?
    func callApiToUpdateProfile(user_id:String,email:String,imageName:String,image:UIImage)  {
        SVProgressHUD.show()
        let userdetailParams = ["user_id":user_id,"token":AppDefaults.getToken(),"email":email]
        let userdetailUrl = BASE_URL.userupdate.urlString()
        WebManager.shared.rquestWithMultiPartFormDataAndParams(userdetailUrl, parametersDictionary: userdetailParams as NSDictionary, mediaArray: [image]) { (result, success) in
            SVProgressHUD.dismiss()
                {
                    if let getResult = result {
                        if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                            if let getData = getResult[kData] as? [String:Any] {
                                if let getToken = getData[kToken] as? String {
                                    AppDefaults.saveToken(token: getToken)
                                }
                                guard let resultObject = try? JSONSerialization.data(withJSONObject: getData, options: .prettyPrinted) else { return }
                                do {
                                    let userObj = try JSONDecoder().decode(UserModel.self, from: resultObject)
                                    AppDefaults.saveUser(user: userObj)
                                    self.delegate?.updateProfiledSuccess(message: "Profile Update Successfully", userModel: userObj)
                                } catch {
                                    LogManager.printVariable(variable:error )
                                }
                            } else {
                                if let getMessage = result?[kMessage] as? String {
                                    self.delegate?.updateProfileFaiure(message: getMessage)
                                }
                            }
                            
                        } else {
                            if let getMessage = result?[kMessage] as? String {
                                self.delegate?.updateProfileFaiure(message: getMessage)
                            }
                        }
                    }
                    
            }
        }
        
    }
}
