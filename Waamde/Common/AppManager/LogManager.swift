

import Foundation
import UIKit

private var isPrint:Bool = true
class LogManager: NSObject {
    class var isPrintOn:Bool {
        set(value){
            isPrint = value
        }
        get {
            return isPrint
        }
    }
    
    class func printVariable(variable: Any? ,funcStr: String = #function,line:Int = #line, file:String = #file) {
        if isPrint {
            guard let variable = variable else {
                debugPrint("In \(file) with in Function \(funcStr) variable value = nil at line:\(line)")
                return
            }
            debugPrint("In \(file) with in Function \(funcStr)  at line:\(line) variable value = ")
            debugPrint(variable)
        }
    }
    
    
    class func printCurrentTime(line:Int = #line){
        debugPrint("current time is \(Date()) at line:\(line)")
    }
}
