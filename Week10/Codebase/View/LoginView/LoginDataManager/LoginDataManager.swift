//
//  LoginDataManager.swift
//  Codebase
//
//  Created by 정재욱 on 12/7/23.
//

import Alamofire

class LoginDataManager {
    func login(_ viewController: LoginViewController, _ body: LoginInput) {
        AF.request("http://catstagram.jeuke.com:8080/users/login", method: .post, parameters: body).validate().responseDecodable(of: LoginModel.self) { response in
            switch response.result {
            case .success(let result):
                viewController.successLoginAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

