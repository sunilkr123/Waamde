//
//  DesignManager.swift
//  EasyExpense
//
//  Created By"Shiv Mohan Singh" on 11/08/16.
//  Copyright © 2016 Bruce. All rights reserved.
//

import UIKit
import MessageUI



@objcMembers class DesignManager: NSObject{
    //MARK: - Properities
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    var isAddVisibe = false;
    //MARK: - Singleton Method
    class var shared: DesignManager {
        struct Static {
            static let instance: DesignManager = DesignManager()
        }
        return Static.instance
    }
   
    //MARK:- Load a Storyboard with identifier
    static func loadViewControllerFromStroyBoardWithName(_ storyboardName:StoryBoardName,name:ViewControllerName) -> UIViewController {
        let storyboard:UIStoryboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name.rawValue)
        return vc
    }
    
 //MARK:- Show Alert
    
    @objc static func showAlertWithTitle(_ title:String, message:String, viewController:UIViewController) -> Void{
        
        DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
                let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
            }
            alert.addAction(alertAction)
            
            viewController.present(alert, animated: true, completion: nil)

        }
        
        
    }
       
    

    static func loadXIBForName(nibName:String) -> UIView {
        let arr = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)
        let mainView = arr?.last
        return mainView as! UIView
    }
        
    
    static func gradientImage(size: CGSize, color1: CIColor, color2: CIColor) -> UIImage {

        let context = CIContext(options: nil)
        let filter = CIFilter(name: "CILinearGradient")
        var startVector: CIVector
        var endVector: CIVector

        filter!.setDefaults()

        startVector = CIVector(x: size.width * 0.5, y: 0)
        endVector = CIVector(x: size.width * 0.5, y: size.height * 0.8)

        filter!.setValue(startVector, forKey: "inputPoint0")
        filter!.setValue(endVector, forKey: "inputPoint1")
        filter!.setValue(color1, forKey: "inputColor0")
        filter!.setValue(color2, forKey: "inputColor1")

        let image = UIImage(cgImage: context.createCGImage(filter!.outputImage!, from: CGRect(x: 0, y: 0, width: size.width, height: size.height))!)
        return image
    }
    
    
}

