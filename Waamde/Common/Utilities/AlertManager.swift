

import UIKit

class AlertManager: NSObject {
    
    class func showAlertControllerWith(title: AlertTitle = .appName, message: Messages, controller: UIViewController, completionOnPresentationOfAlert:  NullableCompletion = nil, buttons: AlertButton...) {
        if message.value.count > 0 {
            let alertController = UIAlertController(title: title.value, message: message.value, preferredStyle: UIAlertController.Style.alert)
            for button in buttons {
                let buttonStyle = buttons.count > 1 ? button.style : .default
                let alertAction = UIAlertAction(title: button.name, style: buttonStyle) { _ in
                    if let actionToPerform = button.action {
                        actionToPerform()
                    }
                }
                alertController.addAction(alertAction)
            }
            controller.present(alertController, animated: true, completion: completionOnPresentationOfAlert)
        } else {
            return
        }
    }
}
