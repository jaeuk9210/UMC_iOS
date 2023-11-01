//
//  LoginViewController.swift
//  Week4_Study
//
//  Created by 정재욱 on 10/13/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    var email = String()
    var password = String()
    
    var userInfo: UserInfo?

    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttribute()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func emailTextFieldEditingChange(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.loginButton.backgroundColor = text.isValidEmail() ?  .facebook : .disabledButton
        self.email = text
    }
    
    @IBAction func passwordTextFieldEdtingChange(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.loginButton.backgroundColor = text.count > 2 ?  .facebook : .disabledButton
        self.password = text
    }
    
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        if userInfo?.email == self.email
            && userInfo?.password == self.password {
            let vc = storyboard?.instantiateViewController(withIdentifier: "MainTabView") as! UITabBarController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        
        registerViewController.delegate = self
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    private func setupAttribute() {
        let text1 = "계정이 없으신가요?"
        let text2 = "가입하기"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        let color2 = UIColor.facebook
        
        let attributes = generateButtonAttribute(self.registerButton, texts: text1, text2, fonts: font1, font2, colors: color1, color2)
        
        self.registerButton.setAttributedTitle(attributes, for: .normal)
    }
}


extension LoginViewController: SendData{
    func send(userInfo: UserInfo) {
        self.userInfo = userInfo
    }
}

protocol SendData {
    func send(userInfo: UserInfo)
}
