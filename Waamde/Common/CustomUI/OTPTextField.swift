

import UIKit
protocol MyTextFieldDelegate: class {
    func textFieldDidDelete()
}

class OTPTextField: UITextField {
    weak var myDelegate: MyTextFieldDelegate?
    
    override func deleteBackward() {
        super.deleteBackward()
        myDelegate?.textFieldDidDelete()
    }
}
