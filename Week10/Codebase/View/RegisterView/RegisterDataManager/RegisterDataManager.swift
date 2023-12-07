//
//  RegisterDataManager.swift
//  Codebase
//
//  Created by 정재욱 on 12/7/23.
//

import Alamofire

class RegisterDataManager {
    func register(_ viewController: RegisterViewController, _ body: RegisterInput) {
        AF.request("http://catstagram.jeuke.com:8080/users/register", method: .post, parameters: body).validate().responseDecodable(of: RegisterModel.self) { response in
            switch response.result {
            case .success(let result):
                viewController.successRegisterAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

