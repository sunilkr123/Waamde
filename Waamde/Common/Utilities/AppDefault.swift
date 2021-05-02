

import Foundation

class AppDefaults: NSObject {
    
    class func saveUser(user:UserModel) {
        do {
            let data = try JSONEncoder().encode(user)
            UserDefaults.standard.set(data, forKey: UserDefaultConstant.kUser)
        } catch {
        }
        
    }
    
    class func removeUser() {
        UserDefaults.standard.removeObject(forKey: UserDefaultConstant.kUser)
    }
    
    class func setLogin(value:Bool) {
        UserDefaults.standard.set(value, forKey: UserDefaultConstant.kIsLogin)
    }
    
    class func isLogin() -> Bool? {
        return UserDefaults.standard.value(forKey: UserDefaultConstant.kIsLogin) as? Bool
    }
    
    class func loadCurrentUser() -> UserModel? {
        if let data = UserDefaults.standard.data(forKey: UserDefaultConstant.kUser) {
            do {
                let user = try JSONDecoder().decode(UserModel.self, from: data)
                return user
            }
            catch {
                LogManager.printVariable(variable: error)
            }
        }
        return nil
    }
    
    class func saveToken(token:String) {
        UserDefaults.standard.set(token, forKey:UserDefaultConstant.kToken)
    }
    
    class func getToken() -> String? {
        return UserDefaults.standard.value(forKey: UserDefaultConstant.kToken) as? String
    }
    class func removeToken() {
        UserDefaults.standard.removeObject(forKey:UserDefaultConstant.kToken)
    }
    
    class func saveAccessToken(token:String) {
        UserDefaults.standard.set(token, forKey:UserDefaultConstant.kAccessToken)
        UserDefaults.standard.synchronize()
       }
       
    class func getAccessToken() -> String? {
           return UserDefaults.standard.value(forKey: UserDefaultConstant.kAccessToken) as? String
    }
    
    class func saveRefreshToken(token:String) {
        UserDefaults.standard.set(token, forKey:UserDefaultConstant.kRefreshToken)
        UserDefaults.standard.synchronize()
       }
       
    class func getRefreshToken() -> String? {
           return UserDefaults.standard.value(forKey: UserDefaultConstant.kRefreshToken) as? String
    }
}
