//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Andrew Clissold
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//      The above copyright notice and this permission notice shall be included in all
//      copies or substantial portions of the Software.
//
//      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//      IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//      FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//      AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//      LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//      SOFTWARE.
//

import UIKit


@IBDesignable


class CardView: UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var addTouchAnimation: Bool = false
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 2
    @IBInspectable var shadowColor: UIColor? = UIColor.lightGray
    @IBInspectable var shadowOpacity: Float = 0.5
    
    
    fileprivate var tap = UITapGestureRecognizer()
    var originalFrame = CGRect.zero
    
    
    public var onCardTap: (() -> Void)?
    
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        
        
        
        
    }
    func removeShadow(){
        layer.shadowColor = UIColor.clear.cgColor
    }
    

    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
        
    }
    
    
    open func initialize() {
        // Tap gesture init
        self.addGestureRecognizer(tap)
        tap.delegate = self
        tap.cancelsTouchesInView = false
        
        
    }
    
    
    //MARK: - Actions
    
    @objc func cardTapped() {
        if let onCardClicked = self.onCardTap{
            onCardClicked()
        }
        
        resetAnimated()
        
    }
    
    
    //MARK: - Animations
    
    private func shrinkAnimated() {
        if(addTouchAnimation){
            UIView.animate(withDuration: 0.2, animations: { self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9) })
        }
    }
    
    private func resetAnimated() {
        if(addTouchAnimation){
            UIView.animate(withDuration: 0.2, animations: { self.transform = CGAffineTransform.identity })
        }
    }
}


//MARK: - Gesture Delegate

extension CardView: UIGestureRecognizerDelegate {
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        cardTapped()
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetAnimated()
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let superview = self.superview {
            originalFrame = superview.convert(self.frame, to: nil)
            
        }
        shrinkAnimated()
    }
}

extension UIView {
    
  // OUTPUT 1
    
  public func addshadow(opacity: Float = 4.0, borderWidth: CGFloat = 1.0) {
      self.layer.shadowOffset = CGSize(width: borderWidth, height: borderWidth)
      self.layer.shadowOpacity = opacity
      self.layer.shadowRadius = 3
      self.layer.shadowColor = UIColor.lightGray.cgColor
      self.layer.masksToBounds = false
  }
    public func removeshadow(opacity: Float = 0, borderWidth: CGFloat = 0) {
        self.layer.shadowOffset = CGSize(width: borderWidth, height: borderWidth)
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = 0
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = false
    }
}
extension UIColor{
    @objc static func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    convenience init(hex string: String) {
      var hex = string.hasPrefix("#")
        ? String(string.dropFirst())
        : string
      guard hex.count == 3 || hex.count == 6
        else {
          self.init(white: 1.0, alpha: 0.0)
          return
      }
      if hex.count == 3 {
        for (index, char) in hex.enumerated() {
          hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
        }
      }

      self.init(
        red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
        green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
        blue:  CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0, alpha: 1.0)
    }

      @available(*, deprecated)
    public static func hex(string: String) -> UIColor {
      return UIColor(hex: string)
    }

    public func colorWithMinimumSaturation(minSaturation: CGFloat) -> UIColor {
      var (hue, saturation, brightness, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 0.0)
      getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

      return saturation < minSaturation
        ? UIColor(hue: hue, saturation: minSaturation, brightness: brightness, alpha: alpha)
        : self
    }

    public func alpha(_ value: CGFloat) -> UIColor {
      return withAlphaComponent(value)
    }
}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
