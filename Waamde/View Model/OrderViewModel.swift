

import Foundation
import SVProgressHUD

protocol OrderViewModelDelegate {
    func orderSuccess(message:String, userModel:[OrderModel])
    func orderFaiure(message:String)
    func orderDetailSuccess(message:String, userModel:OrderDetail)
    func orderDetailFaiure(message:String)
    
}
extension OrderViewModelDelegate {
    func orderSuccess(message:String, userModel:[OrderModel]){}
    func orderFaiure(message:String){}
    func orderDetailSuccess(message:String, userModel:OrderDetail){}
    func orderDetailFaiure(message:String){}
   
}

class orderViewModel {
    
    var orderVMDelegate: OrderViewModelDelegate?
    
    
    func callOrderApi() {
        SVProgressHUD.show()
        let socialLoginParams = ["user_id":AppDefaults.loadCurrentUser()?.id ?? ""] as [String:Any]
        let socialLoginUrl = BASE_URL.order_list.urlString()
        WebManager.shared.requestPOSTURL(socialLoginUrl, params: socialLoginParams) { (result, error) in
            SVProgressHUD.dismiss()
            if let getResult = result {
                if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                    if let getData = getResult[kData] as? [[String:Any]] {
                       
                        if let getUser = getResult[kData] as? [[String:Any]] {
                            guard let resultObject = try? JSONSerialization.data(withJSONObject: getUser, options: .prettyPrinted) else { return }
                            do {
                                let userObj = try JSONDecoder().decode(Array<OrderModel>.self, from: resultObject)
                                //AppDefaults.saveUser(user: userObj)
                                self.orderVMDelegate?.orderSuccess(message: "", userModel: userObj)
                            } catch {
                                LogManager.printVariable(variable:error )
                            }
                        } else {
                            if let getMessage = result?[kMessage] as? String {
                                self.orderVMDelegate?.orderFaiure(message: getMessage)
                            }
                        }
                    } else {
                        if let getError = result?[kError] as? [[String:Any]] {
                            
                        }
                        if let getMessage = result?[kMessage] as? String {
                            self.orderVMDelegate?.orderFaiure(message: getMessage)
                        }
                    }
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.orderVMDelegate?.orderFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
    
    func callOrderDetailApi(order_Id:String) {
        SVProgressHUD.show()
        let socialLoginParams = ["order_id":order_Id] as [String:Any]
        let socialLoginUrl = BASE_URL.orderDetail.urlString()
        WebManager.shared.requestPOSTURL(socialLoginUrl, params: socialLoginParams) { (result, error) in
            SVProgressHUD.dismiss()
            if let getResult = result {
                if let getSuccess = result?[kCode] as? Int, getSuccess == 200 {
                    if let getData = getResult[kData] as? [String:Any] {
                       
                        if let getUser = getResult[kData] as? [String:Any] {
                            guard let resultObject = try? JSONSerialization.data(withJSONObject: getUser, options: .prettyPrinted) else { return }
                            do {
                                let userObj = try JSONDecoder().decode(OrderDetail.self, from: resultObject)
                                //AppDefaults.saveUser(user: userObj)
                                self.orderVMDelegate?.orderDetailSuccess(message: "", userModel: userObj)
                            } catch {
                                LogManager.printVariable(variable:error )
                            }
                        } else {
                            if let getMessage = result?[kMessage] as? String {
                                self.orderVMDelegate?.orderDetailFaiure(message: getMessage)
                            }
                        }
                    } else {
                        if let getError = result?[kError] as? [[String:Any]] {
                            
                        }
                        if let getMessage = result?[kMessage] as? String {
                            self.orderVMDelegate?.orderDetailFaiure(message: getMessage)
                        }
                    }
                    
                } else {
                    if let getMessage = result?[kMessage] as? String {
                        self.orderVMDelegate?.orderDetailFaiure(message: getMessage)
                    }
                }
            } else {
                
            }
        }
    }
}
