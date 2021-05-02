

import UIKit
import Foundation
import Alamofire

protocol WebManagerDelegate :class {
    func tokenExpired()
}

typealias CompletionBlock = (_ result: [String: Any]?, _ error: Bool) -> Void

class WebManager: NSObject {
    static let shared: WebManager = {
        let instance = WebManager()
        return instance
    }()
    weak var delegateWebManager: WebManagerDelegate?
    
    /// request retUrl
    /// - Parameters:
    ///   - strURL: final url
    ///   - params: parmameters
    ///   - onSuccess: on success description
    func requestGETURL(_ strURL: String, params : [String : Any]?, onSuccess:@escaping CompletionBlock) {
        if appDelegate.isNetworkAvailable {
            let header = [kContentType:kApplicationJSON, kAuthorization: "Bearer " + (AppDefaults.getToken() ?? "")]
            Alamofire.request(strURL, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (responseObject) -> Void in
                if responseObject.result.isSuccess {
                    
                    let resJson = responseObject.result.value! as? [String: Any]
                    if let getStatus = resJson?["status"] as? Int, getStatus == 403, let message = resJson?["message"] as? String {// move to home screen in this case
                        if let nav = appDelegate.window?.rootViewController as? UINavigationController{
                            AlertManager.showAlertControllerWith(message: .custom(message), controller: nav, buttons: .ok({
                                // set login root view controller
                                
                            }))
                        }
                    } else {
                        onSuccess(resJson,false)
                    }
                    
                } else if responseObject.result.isFailure {
                    let error : Error = responseObject.result.error!
                    debugPrint(error.localizedDescription)
                    onSuccess(nil, true)
                }
            }
        } else {
            if let nav = appDelegate.window?.rootViewController as? UINavigationController{
                AlertManager.showAlertControllerWith(message: .custom(kNoInternetConnection), controller: nav, buttons: .ok(nil))
            }
            onSuccess(nil, true)
        }
    }
    
    /// request post Url
    /// - Parameters:
    ///   - strURL: final url
    ///   - params: parameters
    ///   - onSuccess: success completion
    func requestPOSTURL(_ strURL : String, params : [String : Any]?, onSuccess:@escaping CompletionBlock) {
        if appDelegate.isNetworkAvailable {
            let header = [kContentType:kApplicationJSON, kAuthorization: "Bearer " + (AppDefaults.getToken() ?? "")]
            Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding(), headers: header).responseJSON { (responseObject) -> Void in
                LogManager.printVariable(variable: responseObject)
                if responseObject.result.isSuccess {
                    let resJson = responseObject.result.value! as? [String: Any]
                    if let getStatus = resJson?["code"] as? Int, getStatus == 403, let message = resJson?["message"] as? String {// move to home screen in this case
                        if let nav = appDelegate.window?.rootViewController as? UINavigationController{
                            AlertManager.showAlertControllerWith(message: .custom(message), controller: nav, buttons: .ok({
                                // if token expire set login controller
//                                appDelegate.setLoginRootViewController()
                                
                            }))
                        }
                    } else {
                        onSuccess(resJson,false)
                    }
                } else if responseObject.result.isFailure {
                    let error : Error = responseObject.result.error!
                    debugPrint(error.localizedDescription)
                    onSuccess(nil, true)
                }
            }
        } else {
            if let nav = appDelegate.window?.rootViewController as? UINavigationController{
                AlertManager.showAlertControllerWith(message: .custom(kNoInternetConnection), controller: nav, buttons: .ok(nil))
            }
            onSuccess(nil, true)
        }
    }
        
    func BoolToString(b: Bool?)->String {
        return b?.description ?? "<None>"
        
    }
    
    func rquestWithMultiPartFormDataAndParams(_ strURL : String, parametersDictionary : NSDictionary?, mediaArray : NSArray?, onSuccess:@escaping CompletionBlock)  {
        if appDelegate.isNetworkAvailable == false{
            if let nav = appDelegate.window?.rootViewController as? UINavigationController{
                AlertManager.showAlertControllerWith(message: .custom(kNoInternetConnection), controller: nav, buttons: .ok(nil))
            }
            onSuccess(nil, true)
            return
        }
        
        var parameters: Parameters = [:]
        if parametersDictionary != nil {
            for (key, value) in parametersDictionary! {
                parameters[key as! String] = value
            }
        }
        
        let header = [kContentType:kApplicationJSON, kAuthorization: "Bearer " + (AppDefaults.getToken() ?? "")]

        var request : Request? = nil
        Alamofire.upload(multipartFormData: {
            multiPartForm in
            
            for (key, value) in parametersDictionary! {
                
                multiPartForm.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as! String)
            }
            if mediaArray != nil && mediaArray?.count ?? 0 > 0 {
                for docModelObj in mediaArray! {
                    if let imageObj = docModelObj as? UIImage, let imageData = imageObj.jpegData(compressionQuality: 0.3){
                        multiPartForm.append(imageData, withName: "photo", fileName: "filename.jpeg", mimeType: "image/jpeg")
                    }
                    else{
                        let imageData = UIImage().jpegData(compressionQuality: 0.3)
                        multiPartForm.append(imageData ?? Data(), withName: "photo", fileName: "filename.jpeg", mimeType: "text/plain")
                    }
                }
            }
            
        }, usingThreshold: UInt64.init(), to: strURL, method: .post, headers:header, encodingCompletion: {
            encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                request = upload
                upload.responseJSON { response in
                  // debugPrint(response)
                    let resJson = response.result.value! as? [String: Any]
                                        if let getStatus = resJson?["status"] as? Int, getStatus == 403, let message = resJson?["message"] as? String {// move to home screen in this case
                                            if let nav = appDelegate.window?.rootViewController as? UINavigationController{
                                                AlertManager.showAlertControllerWith(message: .custom(message), controller: nav, buttons: .ok({
                                                    
                                                }))
                                            }
                                        } else {
                                            onSuccess(resJson,false)
                                        }
                }
            case .failure(let encodingError):
                debugPrint(encodingError.localizedDescription)
                onSuccess(nil, true)
                break
                
            }
        })
    }
}

