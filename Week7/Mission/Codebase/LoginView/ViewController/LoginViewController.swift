//
//  ViewController.swift
//  Codebase
//
//  Created by 정재욱 on 11/11/23.
//

import UIKit

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    var email = String()
    var password = String()
    
    var userInfo: UserInfo?
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_catstagram_logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.placeholder = "이메일"
        textField.addTarget(self, action: #selector(emailTextFieldEditingChange(_:)), for: .editingChanged)
        return textField
    } ()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.borderStyle = .roundedRect
        textField.placeholder = "비밀번호"
        textField.addTarget(self, action: #selector(passwordTextFieldEditingChange(_:)), for: .editingChanged)
        textField.isSecureTextEntry = true
        textField.enablePasswordToggle()
        return textField
    } ()
    
    private lazy var findPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "비밀번호를 잊으셨나요?"
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.textAlignment = .right
        label.textColor = .accent
        return label
    } ()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .disabledButton
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(loginButtonDidTap(_:)), for: .touchUpInside)
        return button
    } ()
    
    private lazy var leftContour: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    } ()
    
    private lazy var rightContour: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    } ()
    
    private lazy var orLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "또는"
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.textAlignment = .center
        return label
    } ()
    
    private lazy var loginWithFaccbookButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.facebook, for: .normal)
        button.setTitle("Facebook으로 로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setImage(UIImage(systemName: "f.square.fill"), for: .normal)
        return button
    } ()
    
    private lazy var loginWithKakaoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Kakao 계정으로 로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setImage(UIImage(systemName: "k.square.fill"), for: .normal)
        button.tintColor = .kakaoLable
        button.backgroundColor = .kakaoBackground
        button.addTarget(self, action: #selector(kakaoLoginButtonDidTap(_:)), for: .touchUpInside)
        return button
    } ()
    
    private lazy var contour: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    } ()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("계정이 없으신가요? 가입하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(registerButtonDidTap(_:)), for: .touchUpInside)
        return button
    } ()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        print(Bundle.main.object(forInfoDictionaryKey: "KakaoAppKey") as! String)
        addViews()
        setAutoLayout()
        
        setupAttribute()
    }
    
    //MARK: - Action
    
    @objc func emailTextFieldEditingChange(_ sender:UITextField) {
        let text = sender.text ?? ""
        loginButton.backgroundColor = (password.count > 2 && text.isValidEmail()) ? .facebook : .disabledButton
        email = text
    }
    
    @objc func passwordTextFieldEditingChange(_ sender:UITextField) {
        let text = sender.text ?? ""
        loginButton.backgroundColor = (text.count > 2 && email.isValidEmail()) ? .facebook : .disabledButton
        password = text
    }
    
    @objc func loginButtonDidTap(_ sender: UIButton) {
        if userInfo?.email == email && userInfo?.password == password {
            let mainTabView = MainTabBarViewController()
            mainTabView.modalPresentationStyle = .fullScreen
            self.present(mainTabView, animated: true)
        }
    }
    
    @objc func registerButtonDidTap(_ sender: UIButton) {
        let registerViewController = RegisterViewController()
        
        registerViewController.delegate = self
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    @objc func kakaoLoginButtonDidTap(_ sender: UIButton) {
        print("kakao login button did tap")
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    //do something
                    _ = oauthToken
                    let mainTabView = MainTabBarViewController()
                    UserDefaults.standard.set(true, forKey: "loginState")
                    
                    UserApi.shared.me() {(user, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            print("me() success.")
                            
                            //do something
                            _ = user
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            
                            appDelegate.userName = user?.kakaoAccount?.profile?.nickname
                            appDelegate.profileImage = user?.kakaoAccount?.profile?.profileImageUrl
                            
                            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(mainTabView, animated: true)
                        }
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("loginWithKakaoAccount() success.")

                        //do something
                        _ = oauthToken
                        let mainTabView = MainTabBarViewController()
                        UserDefaults.standard.set(true, forKey: "loginState")
                        UserApi.shared.me() {(user, error) in
                            if let error = error {
                                print(error)
                            }
                            else {
                                print("me() success.")
                                
                                //do something
                                _ = user
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                
                                appDelegate.userName = user?.kakaoAccount?.profile?.nickname
                                appDelegate.profileImage = user?.kakaoAccount?.profile?.profileImageUrl
                                
                                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(mainTabView, animated: true)
                            }
                        }
                    }
                }
        }
    }
    
    //MARK: - Helpers
    
    private func setupAttribute() {
        let text1 = "계정이 없으신가요?"
        let text2 = "가입하기"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        let color2 = UIColor.facebook
        
        let attributes = generateButtonAttribute(registerButton, texts: text1, text2, fonts: font1, font2, colors: color1, color2)
        
        registerButton.setAttributedTitle(attributes, for: .normal)
    }
    
    private func addViews() {
        [logoImage, emailTextField, passwordTextField, findPasswordLabel, loginButton, leftContour, rightContour, orLable, loginWithFaccbookButton, contour, registerButton, loginWithKakaoButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            //Logo autolayout
            logoImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoImage.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -32),
            logoImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.641026),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor, multiplier: 3.0/10.0),
            
            //Email input autolayout
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -10),
            
            //Password input autolayout
            passwordTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            //Find password label autolayout
            findPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            findPasswordLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            //Login button autolyout
            loginButton.topAnchor.constraint(equalTo: findPasswordLabel.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            loginButton.heightAnchor.constraint(equalToConstant: 54),
            
            //Or label autolayout
            orLable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            orLable.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            
            //Left contour autolayout
            leftContour.centerYAnchor.constraint(equalTo: orLable.centerYAnchor),
            leftContour.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            leftContour.trailingAnchor.constraint(equalTo: orLable.leadingAnchor, constant: -15),
            leftContour.heightAnchor.constraint(equalToConstant: 1),
            
            //Right contour autolayout
            rightContour.centerYAnchor.constraint(equalTo: orLable.centerYAnchor),
            rightContour.leadingAnchor.constraint(equalTo: orLable.trailingAnchor, constant: 15),
            rightContour.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            rightContour.heightAnchor.constraint(equalToConstant: 1),
            
            //Login with Facebook button autolayout
            loginWithFaccbookButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loginWithFaccbookButton.topAnchor.constraint(equalTo: orLable.bottomAnchor, constant: 18),
            
            //Bottom contour autolayout
            contour.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            contour.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            contour.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            contour.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -15),
            contour.heightAnchor.constraint(equalToConstant: 1),
            
            //Register button autolayout
            registerButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            //Kakao login button autolayout
            loginWithKakaoButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loginWithKakaoButton.topAnchor.constraint(equalTo: loginWithFaccbookButton.bottomAnchor, constant: 10)
        ])
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
