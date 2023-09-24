//
//  UICustomButton.swift
//  Week1
//
//  Created by 정재욱 on 2023/09/24.
//

import UIKit

@IBDesignable
class UICustomButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
            self.layer.masksToBounds = false
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.4 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
            self.layer.masksToBounds = false
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 1, height: 4) {
        didSet {
            self.layer.shadowOffset = shadowOffset
            self.layer.masksToBounds = false
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = CGFloat(0.5) {
       didSet {
           self.layer.shadowRadius = shadowRadius
          self.layer.masksToBounds = false
       }
    }
    
    override class var layerClass: AnyClass {
        CAGradientLayer.self
    }
    
    private var gradientLayer: CAGradientLayer {
        layer as! CAGradientLayer
    }
    
    @IBInspectable public var startColor: UIColor = .white {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable public var endColor: UIColor = .red {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable public var startPoint: CGPoint {
        get {
            gradientLayer.startPoint
        }
            
        set {
            gradientLayer.startPoint = newValue
        }
     }
    
    @IBInspectable public var endPoint: CGPoint {
        get {
            gradientLayer.endPoint
        }
        set {
            gradientLayer.endPoint = newValue
        }
     }
    
    private func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
