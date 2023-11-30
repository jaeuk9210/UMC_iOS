//
//  ViewController.swift
//  Codebase
//
//  Created by 정재욱 on 11/11/23.
//

import UIKit
import Combine

import SnapKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {

    //MARK: - Properties
    var email = String()
    var password = String()

    var userInfo: UserInfo?

    var subscriptions = Set<AnyCancellable>()

    private lazy var kakaoAuthViewModel: KakaoAuthViewModel = {
        KakaoAuthViewModel()
    } ()

    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_catstagram_logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.placeholder = "이메일"
        textField.addTarget(self, action: #selector(emailTextFieldEditingChange(_:)), for: .editingChanged)
        return textField
    } ()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
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
        label.text = "비밀번호를 잊으셨나요?"
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.textAlignment = .right
        label.textColor = .accent
        return label
    } ()

    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .disabledButton
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(loginButtonDidTap(_:)), for: .touchUpInside)
        return button
    } ()

    private lazy var leftContour: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    } ()

    private lazy var rightContour: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    } ()

    private lazy var orLable: UILabel = {
        let label = UILabel()
        label.text = "또는"
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.textAlignment = .center
        return label
    } ()

    private lazy var loginWithFaccbookButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "f.square.fill")
        configuration.imagePlacement = .leading
        configuration.imagePadding = 10
        configuration.title = "Facebook으로 로그인"
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .facebook

        let button = UIButton(configuration: configuration)

        return button
    } ()

    private lazy var loginWithKakaoButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "k.square.fill")
        configuration.imagePlacement = .leading
        configuration.imagePadding = 10
        configuration.title = "Kakao 계정으로 로그인"
        configuration.baseForegroundColor = .kakaoLable
        configuration.baseBackgroundColor = .kakaoBackground

        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(kakaoLoginButtonDidTap(_:)), for: .touchUpInside)
        return button
    } ()

    private lazy var contour: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    } ()

    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
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
        setBinding()
    }

    //MARK: - Action

    @objc func emailTextFieldEditingChange(_ sender: UITextField) {
        let text = sender.text ?? ""
        loginButton.backgroundColor = (password.count > 2 && text.isValidEmail()) ? .facebook : .disabledButton
        email = text
    }

    @objc func passwordTextFieldEditingChange(_ sender: UITextField) {
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
        kakaoAuthViewModel.kakaoLogin()
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
        logoImage.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(emailTextField.snp.top).offset(-32)
            $0.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.641026)
            $0.height.equalTo(logoImage.snp.width).multipliedBy(0.3)
        }

        emailTextField.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.bottom.equalTo(passwordTextField.snp.top).offset(-10)
        }

        passwordTextField.snp.makeConstraints {
            $0.center.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }

        findPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(findPasswordLabel.snp.bottom).offset(40)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.height.equalTo(54)
        }

        orLable.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(loginButton.snp.bottom).offset(30)
        }

        leftContour.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(orLable.snp.leading).offset(-15)
            $0.centerY.equalTo(orLable)
        }

        rightContour.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.equalTo(orLable.snp.trailing).offset(15)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.centerY.equalTo(orLable)
        }

        loginWithFaccbookButton.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(orLable.snp.bottom).offset(10)
        }

        contour.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.bottom.equalTo(registerButton.snp.top).offset(-15)
            $0.height.equalTo(1)
        }

        registerButton.snp.makeConstraints {
            $0.centerX.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        loginWithKakaoButton.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(loginWithFaccbookButton.snp.bottom).offset(10)
        }
    }
}

extension LoginViewController: SendData {
    func send(userInfo: UserInfo) {
        self.userInfo = userInfo
    }
}

protocol SendData {
    func send(userInfo: UserInfo)
}

extension LoginViewController {
    fileprivate func setBinding() {
        self.kakaoAuthViewModel.$isLoggedIn.sink { [weak self] isLoggedIn in
            guard self != nil else { return }
            if isLoggedIn {
                let tabVC = MainTabBarViewController()
                UserDefaults.standard.set(true, forKey: "loginState")
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(tabVC, animated: true)
            }
        }.store(in: &subscriptions)
    }
}
