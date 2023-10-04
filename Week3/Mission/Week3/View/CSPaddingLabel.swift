//
//  CSPaddingLabel.swift
//  Week3
//
//  Created by 정재욱 on 10/4/23.
//

import UIKit

@IBDesignable class CSPaddingLabel: UILabel {

        @IBInspectable var cornerRadius : CGFloat = 5
       
        override func draw(_ rect: CGRect) {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
            super.draw(rect)
        }
    
        private var padding = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)

        convenience init(padding: UIEdgeInsets) {
            self.init()
            self.padding = padding
        }

        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.inset(by: padding))
        }

        override var intrinsicContentSize: CGSize {
            var contentSize = super.intrinsicContentSize
            contentSize.height += padding.top + padding.bottom
            contentSize.width += padding.left + padding.right

            return contentSize
        }
    }
