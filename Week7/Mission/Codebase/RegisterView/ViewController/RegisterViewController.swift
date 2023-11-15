//
//  RegisterViewController.swift
//  Codebase
//
//  Created by 정재욱 on 11/11/23.
//

import UIKit

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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_catstagram_logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "친구들의 사진과 동영상을 보려면\n가입하세요"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    } ()
    
    private lazy var loginWithFacebookButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Facebook으로 로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .facebook
        button.setImage(UIImage(systemName: "f.square.fill"), for: .normal)
        button.imageView?.tintColor = .white
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
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.placeholder = "이메일"
        return textField
    } ()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.borderStyle = .roundedRect
        textField.placeholder = "성명"
        return textField
    } ()
    
    private lazy var nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.borderStyle = .roundedRect
        textField.placeholder = "사용자 이름"
        return textField
    } ()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.borderStyle = .roundedRect
        textField.placeholder = "비밀번호"
        textField.isSecureTextEntry = true
        textField.enablePasswordToggle()
        return textField
    } ()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("가입", for: .normal)
        button.backgroundColor = .disabledButton
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(registerButtonDidTap(_:)), for: .touchUpInside)
        return button
    } ()
    
    private lazy var contour: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    } ()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("계정이 있으신가요? 로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(loginButtonDidTap(_:)), for: .touchUpInside)
        return button
    } ()
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        self.navigationController?.popViewController(animated: true)
        
        let userInfo = UserInfo(email: self.email, name: self.name, nickname: self.nickname, password: self.password)
        delegate?.send(userInfo: userInfo)
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
        
        textFields.forEach{
            textFieldStackView.addArrangedSubview($0)
        }
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            //Logo image autolayout
            logoImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.599661),
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor, multiplier: 3.0/10.0),
            
            //Welcome label autolayout
            welcomeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20),
            
            //Login with facebook button autolayout
            loginWithFacebookButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            loginWithFacebookButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            loginWithFacebookButton.heightAnchor.constraint(equalToConstant: 35),
            loginWithFacebookButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 25),
            
            //Or label autolayout
            orLable.topAnchor.constraint(equalTo: loginWithFacebookButton.bottomAnchor, constant: 35),
            orLable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            //left contour autolayout
            leftContour.heightAnchor.constraint(equalToConstant: 1),
            leftContour.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            leftContour.trailingAnchor.constraint(equalTo: orLable.leadingAnchor, constant: -15),
            leftContour.centerYAnchor.constraint(equalTo: orLable.centerYAnchor),
            
            //right contour autolayout
            rightContour.heightAnchor.constraint(equalToConstant: 1),
            rightContour.leadingAnchor.constraint(equalTo: orLable.trailingAnchor, constant: 15),
            rightContour.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            rightContour.centerYAnchor.constraint(equalTo: orLable.centerYAnchor),
            
            //Text fields autolayout
            textFieldStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textFieldStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            textFieldStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            textFieldStackView.topAnchor.constraint(equalTo: orLable.bottomAnchor, constant: 25.33),
            
            //Registor button autolayout
            registerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            registerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            registerButton.heightAnchor.constraint(equalToConstant: 45),
            registerButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 25),
            
            //Contour autolayout
            contour.heightAnchor.constraint(equalToConstant: 1),
            contour.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            contour.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            contour.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -15),
            
            //Login button autolayout
            loginButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
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
