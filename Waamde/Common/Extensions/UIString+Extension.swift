

import UIKit

extension String {
    
    func getMaskedNumber() -> String {
        let actualSting = self
        var value = 0
        var maskedNum = ""
        for singleChar in actualSting {
            if value < 4{
                maskedNum.append(singleChar)
            } else if value == 3 || value == 6 {
                maskedNum.append(" ")
            }
            if value >= 4 {
                maskedNum.append("x")
            }
            value += 1
        }
        return maskedNum
    }
    
    func getFormattedNumber() -> String {
        let actualSting = self
        var value = 0
        var maskedNum = ""
        for singleChar in actualSting {
            maskedNum.append(singleChar)
            if value == 3 || value == 6 {
                maskedNum.append(" ")
            }
            value += 1
        }
        return maskedNum
    }
    
    func hexaStringToUIColor() -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    var alphanumeric: String {
           return self.components(separatedBy: CharacterSet.alphanumerics.inverted).joined().lowercased()
       }
}
