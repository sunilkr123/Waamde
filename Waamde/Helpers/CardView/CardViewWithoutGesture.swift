//
//  CardViewWithoutGesture.swift
//  OMTUT
//
//  Created by Shiv Mohan Singh on 17/01/20.
//  Copyright © 2020 Tribond. All rights reserved.
//
import UIKit


@IBDesignable


class CardViewWithoutGesture: UIView {
    
    
    @IBInspectable var addTouchAnimation: Bool = false
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 2
    @IBInspectable var shadowColor: UIColor? = UIColor.lightGray
    @IBInspectable var shadowOpacity: Float = 0.5
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
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
    
    
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
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

extension CardViewWithoutGesture: UIGestureRecognizerDelegate {
    
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


