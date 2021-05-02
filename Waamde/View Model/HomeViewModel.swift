//
//  HomeViewModel.swift
//  Waamde
//
//  Created by Apple on 05/03/21.
//

import Foundation
import SVProgressHUD

protocol HomeViewModelDelegate {
    func homeSuccess(message:String, homeModel:HomeModel)
    func homeFaiure(message:String)
}
extension HomeViewModelDelegate {
    func homeSuccess(message:String, homeModel:HomeModel){}
    func homeFaiure(message:String){}
}

class HomeViewModel {
    
    var homeVMDelegate: HomeViewModelDelegate?
    
    func callGetHomeDataAPI() {
        SVProgressHUD.show(withStatus: "Please wait..")
        let params = ["user_id":AppDefaults.loadCurrentUser()?.id]
        let homeUrl = BASE_URL.home.urlString()
        WebManager.shared.requestPOSTURL(homeUrl, params: params) { (result, error) in
            SVProgressHUD.dismiss()
            if let _ = result {
                if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                   if let getData = result?[kData] as? [String:Any] {
                       guard let resultObj = try? JSONSerialization.data(withJSONObject: getData, options: .prettyPrinted) else {
                           return
                       }
                       do {
                        let categoryData = try JSONDecoder().decode(HomeModel.self, from: resultObj)
                        self.homeVMDelegate?.homeSuccess(message: "", homeModel: categoryData)
                       } catch {
                        LogManager.printVariable(variable:error )
                       }
                   }
                }
            } else {
                if let getMessage = result?[kMessage] as? String {
                    self.homeVMDelegate?.homeFaiure(message:getMessage)
                }
            }
        }
    }
}
