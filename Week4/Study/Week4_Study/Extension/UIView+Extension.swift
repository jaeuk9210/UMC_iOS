//
//  UIView+Extention.swift
//  Week4_Study
//
//  Created by 정재욱 on 10/13/23.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
