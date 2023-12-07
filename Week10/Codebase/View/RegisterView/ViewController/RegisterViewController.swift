//
//  RegisterViewController.swift
//  Codebase
//
//  Created by 정재욱 on 11/11/23.
//

import UIKit

import SnapKit

class RegisterViewController: UIViewController {

    //MARK: - Properties
    var delegate: SendData?

    var email: String = ""
    var name: String = ""
    var nickname: String = ""
    var password: String = ""

    private lazy var backButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.tintColor = .darkGray
        barButtonItem.image = UIImage(systemName: "chevron.left")
        barButtonItem.target = self
        barButtonItem.action = #selector(backButtonDidTap(_:))
        return barButtonItem
    } ()

    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_catstagram_logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()

    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "친구들의 사진과 동영상을 보려면\n가입하세요"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    } ()

    private lazy var loginWithFacebookButton: UIButton = {
        let button = UIButton()
        button.setTitle("Facebook으로 로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .facebook
        button.setImage(UIImage(systemName: "f.square.fill"), for: .normal)
        button.imageView?.tintColor = .white
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

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.placeholder = "이메일"
        return textField
    } ()

    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.borderStyle = .roundedRect
        textField.placeholder = "성명"
        return textField
    } ()

    private lazy var nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.borderStyle = .roundedRect
        textField.placeholder = "사용자 이름"
        return textField
    } ()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.borderStyle = .roundedRect
        textField.placeholder = "비밀번호"
        textField.isSecureTextEntry = true
        textField.enablePasswordToggle()
        return textField
    } ()

    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("가입", for: .normal)
        button.backgroundColor = .disabledButton
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(registerButtonDidTap(_:)), for: .touchUpInside)
        return button
    } ()

    private lazy var contour: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    } ()

    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("계정이 있으신가요? 로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(loginButtonDidTap(_:)), for: .touchUpInside)
        return button
    } ()

    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.contentMode = .scaleToFill
        return stackView
    } ()

    private var mainSubViews: [UIView] {
        [logoImage, welcomeLabel, loginWithFacebookButton, leftContour, rightContour, orLable, textFieldStackView, registerButton, contour, loginButton]
    }

    private var textFields: [UITextField] {
        [emailTextField, nameTextField, nicknameTextField, passwordTextField]
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        addViews()
        setAutoLayout()
        setupTextField()
        setupAttribute()
    }

    //MARK: - Actoins

    @objc
    func backButtonDidTap(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    @objc
    func loginButtonDidTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @objc
    func registerButtonDidTap(_ sender: UIButton) {
        RegisterDataManager().register(self, RegisterInput(email: email, password: password, name: name, username: nickname))
    }

    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""

        switch sender {
        case emailTextField:
            self.isValidEmail = text.isValidEmail()
            self.email = text
        case nameTextField:
            self.isValidName = text.count > 2
            self.name = text
        case nicknameTextField:
            self.isValidNickname = text.count > 2
            self.nickname = text
        case passwordTextField:
            self.isValidPassword = text.isValidPassword()
            self.password = text
        default:
            fatalError("Missing TextField...")
        }
    }

    //MARK: - Helpers
    private func addViews() {
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil

        mainSubViews.forEach {
            view.addSubview($0)
        }

        textFields.forEach {
            textFieldStackView.addArrangedSubview($0)
        }
    }

    private func setAutoLayout() {
        logoImage.snp.makeConstraints {
            $0.top.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.599661)
            $0.height.equalTo(logoImage.snp.width).multipliedBy(0.3)
        }

        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(logoImage.snp.bottom).offset(20)
        }

        loginWithFacebookButton.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.height.equalTo(35)
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(25)
        }

        orLable.snp.makeConstraints {
            $0.top.equalTo(loginWithFacebookButton.snp.bottom).offset(35)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
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

        textFieldStackView.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.top.equalTo(orLable.snp.bottom).offset(25.33)
        }

        registerButton.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.height.equalTo(45)
            $0.top.equalTo(textFieldStackView.snp.bottom).offset(25)
        }

        contour.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.bottom.equalTo(loginButton.snp.top).offset(-15)
        }

        loginButton.snp.makeConstraints {
            $0.centerX.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func validateUserInfo() {
        if isValidEmail
            && isValidName
            && isValidNickname
            && isValidPassword {

            registerButton.isEnabled = true
            UIView.animate(withDuration: 0.33) {
                self.registerButton.backgroundColor = .facebook
            }
        } else {

            registerButton.isEnabled = false
            UIView.animate(withDuration: 0.33) {
                self.registerButton.backgroundColor = .disabledButton
            }
        }
    }

    var isValidEmail = false {
        didSet {
            self.validateUserInfo()
        }
    }

    var isValidName = false {
        didSet {
            self.validateUserInfo()
        }
    }

    var isValidNickname = false {
        didSet {
            self.validateUserInfo()
        }
    }

    var isValidPassword = false {
        didSet {
            self.validateUserInfo()
        }
    }

    private func setupTextField() {
        textFields.forEach { tf in
            tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        }
    }

    private func setupAttribute() {
        let text1 = "계정이 있으신가요?"
        let text2 = "로그인"

        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)

        let color1 = UIColor.darkGray
        let color2 = UIColor.facebook

        let attributes = generateButtonAttribute(self.loginButton, texts: text1, text2, fonts: font1, font2, colors: color1, color2)

        self.loginButton.setAttributedTitle(attributes, for: .normal)
    }
}

extension RegisterViewController {
    func successRegisterAPI(_ result: RegisterModel) {
        if result.isSuccess ?? false {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
