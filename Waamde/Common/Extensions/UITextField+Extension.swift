

import UIKit

extension UITextField {
    
    func setPlaceholderColor() {
        if let getPlaceholder = self.placeholder {
            if let getColor = UIColor.getDarkBlue() {
               self.attributedPlaceholder = NSAttributedString(string: getPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: getColor ])
            }
        }
        
    }
    
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
    
    func updatePhoneNumber(_ replacementString: String?, _ textString: String?) -> Bool {
        guard let textCount = textString?.count else {return true}
        guard let currentString = self.text else {return true}
        if replacementString == "" {
            return true
        } else if textCount == 4 {
            self.text =  currentString + "-"
        } else if textCount == 8 {
            self.text = currentString + "-"
        } else if textCount > 12 || replacementString == " " {
            return false
        }
        return true
    }
}
