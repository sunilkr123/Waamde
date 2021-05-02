

import Foundation
import SVProgressHUD

protocol ProductDetailViewModelDelegate {
    func productDetailSuccess(message:String, userModel:ProductDetailModel)
    func productDetailFaiure(message:String)
    
}
//extension ProductDetailViewModelDelegate {
//    func productDetailSuccess(message:String, userModel:ProductDetailModel){}
//    func productDetailFaiure(message:String){}
//
//}

class productDetailViewModel {
    
    var productVMDelegate: ProductDetailViewModelDelegate?
    
    
    func callProductDetailApi(data:ProductDetailData) {
        SVProgressHUD.show()
        let socialLoginParams = ["product_id":data.product_id] as [String:Any]
        let socialLoginUrl = BASE_URL.product_details.urlString()
        WebManager.shared.requestPOSTURL(socialLoginUrl, params: socialLoginParams) { (result, error) in
            SVProgressHUD.dismiss()
            if let getResult = result {
                if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                    if let getData = getResult[kData] as? [String:Any] {
                        if let getToken = getData[kToken] as? String {
                            AppDefaults.saveToken(token: getToken)
                        }
                        if let getUser = getResult[kData] as? [String:Any] {
                            guard let resultObject = try? JSONSerialization.data(withJSONObject: getUser, options: .prettyPrinted) else { return }
                            do {
                                let userObj = try JSONDecoder().decode(ProductDetailModel.self, from: resultObject)
                                self.productVMDelegate?.productDetailSuccess(message: "", userModel: userObj)
                            } catch {
                                LogManager.printVariable(variable:error )
                            }
                        } else {
                            if let getMessage = result?[kMessage] as? String {
                                self.productVMDelegate?.productDetailFaiure(message: getMessage)
                            }
                        }
                    } else {
                        if let getError = result?[kError] as? [[String:Any]] {
                            
                        }
                        if let getMessage = result?[kMessage] as? String {
                            self.productVMDelegate?.productDetailFaiure(message: getMessage)
                        }
                    }
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.productVMDelegate?.productDetailFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
    
   
}
