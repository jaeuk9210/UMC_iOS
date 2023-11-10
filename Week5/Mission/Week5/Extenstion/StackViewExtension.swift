//
//  StackViewExtension.swift
//  Week5
//
//  Created by 정재욱 on 11/10/23.
//

import UIKit

extension UIStackView {
    func clearSubviews() {
        self.arrangedSubviews.forEach { view in
            self.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
