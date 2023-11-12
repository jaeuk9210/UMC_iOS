//
//  TextFieldExtension.swift
//  Codebase
//
//  Created by 정재욱 on 11/11/23.
//

import UIKit

extension UITextField {
    private func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry) {
            button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
    func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
//        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -16, bottom: 0, trailing: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        button.tintColor = .lightGray
        self.rightView = button
        self.rightViewMode = .always
    }
    
    @IBAction func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
}
