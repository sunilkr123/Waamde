

import Foundation
import SVProgressHUD

protocol ProductListViewModelDelegate {
    func ProdctListSuccess(message:String, userModel:[ProductlistModel])
    func ProdctListFaiure(message:String)
    
}
extension ProductListViewModelDelegate {
    func ProdctListSuccess(message:String, userModel:[ProductlistModel]){}
    func ProdctListFaiure(message:String){}
   
}

class ProductListViewModel {
    
    var ptoductListVMDelegate: ProductListViewModelDelegate?
    
    
    func callProductListApi(category_id:String,user_id:String) {
        SVProgressHUD.show()
        let socialLoginParams = ["category_id":category_id,"user_id":user_id] as [String:Any]
        let socialLoginUrl = BASE_URL.search.urlString()
        WebManager.shared.requestPOSTURL(socialLoginUrl, params: socialLoginParams) { (result, error) in
            SVProgressHUD.dismiss()
            if let getResult = result {
                if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                    if let getData = getResult[kData] as? [[String:Any]] {
                       
                        if let getUser = getResult[kData] as? [[String:Any]] {
                            guard let resultObject = try? JSONSerialization.data(withJSONObject: getUser, options: .prettyPrinted) else { return }
                            do {
                                let userObj = try JSONDecoder().decode(Array<ProductlistModel>.self, from: resultObject)
                                //AppDefaults.saveUser(user: userObj)
                                self.ptoductListVMDelegate?.ProdctListSuccess(message: "", userModel: userObj)
                            } catch {
                                LogManager.printVariable(variable:error )
                            }
                        } else {
                            if let getMessage = result?[kMessage] as? String {
                                self.ptoductListVMDelegate?.ProdctListFaiure(message: getMessage)
                            }
                        }
                    } else {
                        if let getError = result?[kError] as? [[String:Any]] {
                            
                        }
                        if let getMessage = result?[kMessage] as? String {
                            self.ptoductListVMDelegate?.ProdctListFaiure(message: getMessage)
                        }
                    }
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.ptoductListVMDelegate?.ProdctListFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
    func SearchProductListApi(category_id:String,user_id:String,product_name:String,min_price:String,maxPrice:String) {
        SVProgressHUD.show()
        let socialLoginParams = ["category_id":category_id,"product_name":product_name] as [String:Any]
        let socialLoginUrl = BASE_URL.search.urlString()
        WebManager.shared.requestPOSTURL(socialLoginUrl, params: socialLoginParams) { (result, error) in
            SVProgressHUD.dismiss()
            if let getResult = result {
                if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                    if let getData = getResult[kData] as? [[String:Any]] {
                       
                        if let getUser = getResult[kData] as? [[String:Any]] {
                            guard let resultObject = try? JSONSerialization.data(withJSONObject: getUser, options: .prettyPrinted) else { return }
                            do {
                                let userObj = try JSONDecoder().decode(Array<ProductlistModel>.self, from: resultObject)
                                //AppDefaults.saveUser(user: userObj)
                                self.ptoductListVMDelegate?.ProdctListSuccess(message: "", userModel: userObj)
                            } catch {
                                LogManager.printVariable(variable:error )
                            }
                        } else {
                            if let getMessage = result?[kMessage] as? String {
                                self.ptoductListVMDelegate?.ProdctListFaiure(message: getMessage)
                            }
                        }
                    } else {
                        if let getError = result?[kError] as? [[String:Any]] {
                            
                        }
                        if let getMessage = result?[kMessage] as? String {
                            self.ptoductListVMDelegate?.ProdctListFaiure(message: getMessage)
                        }
                    }
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.ptoductListVMDelegate?.ProdctListFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
   
}
