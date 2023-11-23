//
//  ViewController.swift
//  Week8
//
//  Created by 정재욱 on 11/24/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var id = String()
    var password = String()

    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.text = "로그인"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    } ()

    private lazy var formStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        return view
    } ()

    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.placeholder = "아이디"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(emailTextFieldEditingChange(_:)), for: .editingChanged)
        return textField
    } ()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.addTarget(self, action: #selector(passwordTextFieldEditingChange(_:)), for: .editingChanged)
        textField.enablePasswordToggle()
        return textField
    } ()

    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        return view
    } ()

    private lazy var loginButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "로그인"
        configuration.baseForegroundColor = .white

        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(loginButtonTouch(_:)), for: .touchUpInside)
        return button
    } ()

    private lazy var registerButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "회원가입"
        configuration.baseForegroundColor = .white

        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(registerButtonTouch(_:)), for: .touchUpInside)
        return button
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addView()
        setLayout()
    }

    @objc func emailTextFieldEditingChange(_ sender: UITextField) {
        let text = sender.text ?? ""
        id = text
    }

    @objc func passwordTextFieldEditingChange(_ sender: UITextField) {
        let text = sender.text ?? ""
        password = text
    }

    @objc func loginButtonTouch(_ sender: UIButton) {
        var message: String
        
        if !(idTextField.text?.isEmpty ?? true) && !(passwordTextField.text?.isEmpty ?? true) {
            if (idTextField.text == UserDefaults.standard.string(forKey: "id")) && (passwordTextField.text == UserDefaults.standard.string(forKey: "password")) {
                message = "로그인 성공"
            } else {
                message = "아이디 혹은 비밀번호 오류"
            }
        } else {
            message = "아이디 혹은 비밀번호 오류"
        }
        
        let alertController = UIAlertController(title: "로그인", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(defaultAction)

        present(alertController, animated: true, completion: nil)
    }

    @objc func registerButtonTouch(_ sender: UIButton) {
        var message: String

        if !(idTextField.text?.isEmpty ?? true) && !(passwordTextField.text?.isEmpty ?? true) {
            if(idTextField.text != (UserDefaults.standard.string(forKey: "id"))) {
                UserDefaults.standard.set(self.idTextField.text, forKey: "id")
                UserDefaults.standard.set(self.passwordTextField.text, forKey: "password")
                message = "회원가입 완료"
            } else {
                message = "존재하는 아이디"
            }
        } else {
            message = "아이디/비밀번호 입력"
        }

        let alertController = UIAlertController(title: "회원가입", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(defaultAction)

        present(alertController, animated: true, completion: nil)
    }

    private func addView() {
        view.addSubview(titleLable)
        view.addSubview(formStackView)
        formStackView.addArrangedSubview(idTextField)
        formStackView.addArrangedSubview(passwordTextField)
        formStackView.addArrangedSubview(buttonStackView)
        buttonStackView.addArrangedSubview(loginButton)
        buttonStackView.addArrangedSubview(registerButton)
    }

    private func setLayout() {
        titleLable.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.centerY.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
        }

        formStackView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.center.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

