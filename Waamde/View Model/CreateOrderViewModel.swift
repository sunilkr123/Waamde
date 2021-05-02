

import Foundation
import SVProgressHUD

protocol CreateOrderViewModelDelegate {
    func CreateOrderSuccess(message:String, userModel:CreareOrderData?)
    func CreateOrderFaiure(message:String)
    
}
extension CreateOrderViewModelDelegate {
    func CreateOrderSuccess(message:String, userModel:CreareOrderData?){}
    func CreateOrderFaiure(message:String){}
   
}

class CreateOrderViewModel {
    
    var CreateOrderVMDelegate: CreateOrderViewModelDelegate?
    
    
    func callCreateOrderApi(cart_id:String,user_id:String,total_amount:Int,trans_id:String,order_type:String,email:String,name:String,country:String,phone:String) {
        SVProgressHUD.show()
        let socialLoginParams = ["cart_id":cart_id,"user_id":user_id,"total_amount":"\(total_amount)","trans_id":trans_id,"order_type":order_type,"email":email,"name":name,"country":country,"phone":phone] as [String:Any]
        let socialLoginUrl = BASE_URL.createOrder.urlString()
        WebManager.shared.requestPOSTURL(socialLoginUrl, params: socialLoginParams) { (result, error) in
            SVProgressHUD.dismiss()
            if let getResult = result {
                if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                    if let getData = getResult[kData] as? [String:Any] {
                       
                        if let getUser = getResult[kData] as? [String:Any] {
                            guard let resultObject = try? JSONSerialization.data(withJSONObject: getUser, options: .prettyPrinted) else { return }
                            do {
                                let userObj = try JSONDecoder().decode(CreareOrderData.self, from: resultObject)
                                //AppDefaults.saveUser(user: userObj)
                                self.CreateOrderVMDelegate?.CreateOrderSuccess(message: "", userModel: userObj)
                            } catch {
                                LogManager.printVariable(variable:error )
                            }
                        } else {
                            if let getMessage = result?[kMessage] as? String {
                                self.CreateOrderVMDelegate?.CreateOrderFaiure(message: getMessage)
                            }
                        }
                    } else {
                        if let getError = result?[kError] as? [[String:Any]] {
                            
                        }
                        if let getMessage = result?[kMessage] as? String {
                            self.CreateOrderVMDelegate?.CreateOrderFaiure(message: getMessage)
                        }
                    }
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.CreateOrderVMDelegate?.CreateOrderFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
    
    
}
