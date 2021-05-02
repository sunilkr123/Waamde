//
//  HomeViewModel.swift
//  Waamde
//
//  Created by Apple on 05/03/21.
//

import Foundation
import SVProgressHUD

protocol WishViewModelDelegate {
    func wishSuccess(message:String, products:[WishListProductModel])
    func wishFaiure(message:String)
}
extension WishViewModelDelegate {
    func wishSuccess(message:String, products:[WishListProductModel]){}
    func wishFaiure(message:String){}
}

class WishListViewModel {
    
    var wishVMDelegate: WishViewModelDelegate?
    
    func callGetWishListDataAPI() {
        SVProgressHUD.show()
        let user = AppDefaults.loadCurrentUser()
        let params = ["user_id":AppDefaults.loadCurrentUser()?.id]
        let categoryUrl = BASE_URL.wishList.urlString()
        WebManager.shared.requestPOSTURL(categoryUrl, params: params as [String : Any]) { (result, error) in
            SVProgressHUD.dismiss()
            if let _ = result {
                if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                   if let getData = result?[kData] as? [[String:Any]] {
                       guard let resultObj = try? JSONSerialization.data(withJSONObject: getData, options: .prettyPrinted) else {
                           return
                       }
                       do {
                    
                        let categoryData = try JSONDecoder().decode(Array<WishListProductModel>.self, from: resultObj);
                        self.wishVMDelegate?.wishSuccess(message: "", products: categoryData)
                       } catch {
                        LogManager.printVariable(variable:error )
                       }
                   }
                }
            } else {
                if let getMessage = result?[kMessage] as? String {
                    self.wishVMDelegate?.wishFaiure(message:getMessage)
                }
            }
        }
    }
}
