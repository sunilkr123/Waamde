//
//  AppDelegate.swift
//  Waamde
//
//  Created by Apple on 26/01/21.
//

import UIKit
import Stripe
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UserDetailViewModelDelegate {

    var window:UIWindow?
    fileprivate var navigationController: UINavigationController?
    public var isNetworkAvailable: Bool = false
    var userVm = userdetailViewModel()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        userVm.userdetailVMDelegate = self
        
        StripeAPI.defaultPublishableKey = "pk_test_51IfPxvSHxqa1G0j8jhaMMj79K2jgWcFXWU7awfFNcytMFSG5inREUSMQfqnSf9wdW0kLoym1DxrrwQYjWfCLJ03i00gBdRenv5"
        // Override point for customization after application launch
        window = UIWindow(frame: UIScreen.main.bounds)
        // Or "Admin"
        window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        window!.makeKeyAndVisible()
        self.setRootViewController()
        ReachabilityHelper.shared.initNetworkReachability { (isNetwork, isWifi, isMobile) in
            self.isNetworkAvailable = isNetwork
            if let id = AppDefaults.loadCurrentUser()?.id{
                self.userVm.callUserDetailAPI(user_id: "\(id)")
            }
        }
        
        return true
    }
    func userdetailSuccess(message: String, userModel: UserModel) {
        
    }
    func userdetailFaiure(message: String) {
        
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


    /// set root view controller
    /// - Parameter moveToLogin: controller
       func setRootViewController(moveToLogin:Bool = false) {
        let vc = DesignManager.loadViewControllerFromStroyBoardWithName(.main, name: .roottab)
           self.navigate(with: vc)
       }
    
    /// navigate to controller
    /// - Parameter initialViewController: controller
    func navigate(with initialViewController:UIViewController) {
        navigationController = UINavigationController(rootViewController: initialViewController)
        self.window?.rootViewController = navigationController
        navigationController?.isNavigationBarHidden = true
        self.window?.makeKeyAndVisible()
    }
}

