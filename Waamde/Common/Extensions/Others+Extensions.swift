

import Foundation
import UIKit

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

extension UITableView {
    
    func AddBottomInsets() {
        if UIDevice().hasNotch {
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: 110, right: 0)
            self.contentInset = insets
        } else {
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: 76, right: 0)
            self.contentInset = insets
        }
    }
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.white
        messageLabel.backgroundColor = UIColor.clear
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        messageLabel.sizeToFit()
        messageLabel.tag = -2001
        self.bounces = false
        self.backgroundView = messageLabel
    }
    
    func setEmptyAttributedMessage(_ message: NSAttributedString) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        messageLabel.attributedText = message
        messageLabel.textColor = UIColor.white
        messageLabel.backgroundColor = UIColor.clear
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        messageLabel.sizeToFit()
        messageLabel.tag = -2001
        self.bounces = false
        self.backgroundView = messageLabel
    }
        
    func setEmptyMessageLableTextColor(_ colorTxt: UIColor) {
        if let messageLabel = self.viewWithTag(-2001) as? UILabel {
            messageLabel.textColor = colorTxt
        }
    }
    
    func restore() {
        //self.bounces = true
        self.backgroundView = nil
    }

}

extension UICollectionView {
    func AddBottomInsets() {
        if UIDevice().hasNotch {
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: 110, right: 0)
            self.contentInset = insets
        } else {
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: 76, right: 0)
            self.contentInset = insets
        }
    }
}
