//
//  StringExtensioin.swift
//  Codebase
//
//  Created by 정재욱 on 11/11/23.
//

import Foundation

extension String {
    func isValidPassword() -> Bool {
        let regularExpression = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[\\d])(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)

        return passwordValidation.evaluate(with: self)
    }

    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        return emailTest.evaluate(with: self)
    }
}
