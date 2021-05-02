

import Foundation
import SVProgressHUD

protocol AddWishListViewModelDelegate {
    func AddWishListSuccess(message:String, userModel:AddWishListModel?)
    func AddWishListFaiure(message:String)
    
}
extension AddWishListViewModelDelegate {
    func AddWishListSuccess(message:String, userModel:AddWishListModel?){}
    func AddWishListFaiure(message:String){}
   
}

class AddWishListViewModel {
    
    var addWishVMDelegate: AddWishListViewModelDelegate?
    
    
    func callAddWishListApi(product_id:String,user_id:String) {
        SVProgressHUD.show()
        let socialLoginParams = ["product_id":product_id,"user_id":user_id] as [String:Any]
        let socialLoginUrl = BASE_URL.addwishlist.urlString()
        WebManager.shared.requestPOSTURL(socialLoginUrl, params: socialLoginParams) { (result, error) in
            SVProgressHUD.dismiss()
            if let getResult = result {
                if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                    if let getData = getResult[kData] as? [String:Any] {
                       
                        if let getUser = getResult[kData] as? [String:Any] {
                            guard let resultObject = try? JSONSerialization.data(withJSONObject: getUser, options: .prettyPrinted) else { return }
                            do {
                                let userObj = try JSONDecoder().decode(AddWishListModel.self, from: resultObject)
                                //AppDefaults.saveUser(user: userObj)
                                
                                self.addWishVMDelegate?.AddWishListSuccess(message: "", userModel: userObj)
                            } catch {
                                LogManager.printVariable(variable:error )
                            }
                        } else {
                            if let getMessage = result?[kMessage] as? String {
                                self.addWishVMDelegate?.AddWishListFaiure(message: getMessage)
                            }
                        }
                    } else {
                        if let getError = result?[kError] as? [[String:Any]] {
                            
                        }
                        if let getMessage = result?[kMessage] as? String {
                            self.addWishVMDelegate?.AddWishListFaiure(message: getMessage)
                        }
                    }
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.addWishVMDelegate?.AddWishListFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
    
    
    func RemoveAddWishListApi(product_id:String,user_id:String) {
        SVProgressHUD.show()
        let socialLoginParams = ["product_id":product_id,"user_id":user_id,"status":"delete"] as [String:Any]
        let socialLoginUrl = BASE_URL.addwishlist.urlString()
        WebManager.shared.requestPOSTURL(socialLoginUrl, params: socialLoginParams) { (result, error) in
            SVProgressHUD.dismiss()
            if let getResult = result {
                if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                    self.addWishVMDelegate?.AddWishListSuccess(message: "", userModel: nil)
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.addWishVMDelegate?.AddWishListFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
   
}
extension ProductLIstVC:AddWishListViewModelDelegate{
    func wishSuccess(message: String, products: [WishListProductModel]) {
        
    }
    func wishFaiure(message: String) {
        
    }
}
