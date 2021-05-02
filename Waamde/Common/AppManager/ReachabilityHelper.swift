

import UIKit
import Alamofire



class ReachabilityHelper: NSObject {
    
    static let shared = ReachabilityHelper()
    
    /// is ther have network reachablitiy
    /// - Parameter onCompletion: on completion give us data
    func initNetworkReachability(onCompletion: @escaping(_ isNetworkAvailable: Bool, _ isWifiAvailable: Bool, _ isDataAvailable: Bool) -> Void){
        let reachability = NetworkReachabilityManager()
        var firstTime = false
        if reachability?.isReachable == true {
            firstTime = true
            if reachability?.isReachableOnEthernetOrWiFi == true {
                onCompletion(true, true, false)
            }
            else {
                onCompletion(true, false, true)
            }
        }
        else {
            onCompletion(false, false, false)
        }
        reachability?.startListening()
        reachability?.listener = { status in
            if reachability?.isReachable == true {
                if firstTime == false{
                    if reachability?.isReachableOnEthernetOrWiFi == true {
                        onCompletion(true, true, false)
                    }
                    else {
                        onCompletion(true, false, true)
                    }
                }
                firstTime = false
            }
            else {
                onCompletion(false, false, false)
            }
        }
    }
}

