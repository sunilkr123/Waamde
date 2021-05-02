
import Foundation
import UIKit

extension UIView {

    /// It return Attributed String with different font size
    /// - Parameters:
    ///   - strFirst: First text
    ///   - strSecond: Second Text
    func getAttributeText(_ strFirst:String, strSecond:String)->NSAttributedString{
        let textAttributesOne = [NSAttributedString.Key.font: UIFont.sfProDisplaySemiBold(size: 16)]
        let textAttributesTwo = [NSAttributedString.Key.font: UIFont.sfProDisplayBold(size: 18)]
        let textPartOne = NSMutableAttributedString(string: strFirst, attributes: textAttributesOne)
        let textPartTwo = NSMutableAttributedString(string: strSecond, attributes: textAttributesTwo)
        let textCombination = NSMutableAttributedString()
        textCombination.append(textPartOne)
        textCombination.append(textPartTwo)
        return textCombination
    }
}

func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text

    label.sizeToFit()
    return label.frame.height
}
