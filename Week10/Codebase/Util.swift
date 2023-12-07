//
//  Util.swift
//  Codebase
//
//  Created by 정재욱 on 11/16/23.
//

import UIKit

import Alamofire

struct LoginStateModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String
}

func checkLoginStatus(loggedIn: () -> (), loggedOut: () -> ()) {
    let loginState = UserDefaults.standard.bool(forKey: "loginState")
    
    if loginState == false {
        loggedOut()
    } else {
        loggedIn()
    }
    
    UserDefaults.standard.synchronize()
}

func updateLoginStatus() {
    let authToken = UserDefaults.standard.string(forKey: "authKey")
    
    if authToken != nil {
        let header: HTTPHeaders = ["Authorization": authToken!]
        AF.request("http://catstagram.jeuke.com:8080/users/verifyToken", method: .get, headers: header).validate().responseDecodable(of: LoginStateModel.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSuccess {
                    UserDefaults.standard.set(true, forKey: "loginState")
                } else {
                    UserDefaults.standard.set(false, forKey: "loginState")
                }
            case .failure(_):
                UserDefaults.standard.set(false, forKey: "loginState")
            }
        }
    } else {
        UserDefaults.standard.set(false, forKey: "loginState")
    }
}

func updateUserInfo(after: @escaping () -> ()) {
    after()
}

func afterLogin() {
    let mainTabView = MainTabBarViewController()
    UserDefaults.standard.set(true, forKey: "loginState")
    updateUserInfo(after: {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(mainTabView, animated: true)
    })
}
