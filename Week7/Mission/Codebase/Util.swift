//
//  Util.swift
//  Codebase
//
//  Created by 정재욱 on 11/16/23.
//

import UIKit

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

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
    if (AuthApi.hasToken()) {
        UserApi.shared.accessTokenInfo { (_, error) in
            if let error = error {
                if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                    UserDefaults.standard.set(false, forKey: "loginState")
                }
                else {
                    UserDefaults.standard.set(false, forKey: "loginState")
                }
            }
            else {
                UserDefaults.standard.set(true, forKey: "loginState")
            }
        }
    }
    else {
        UserDefaults.standard.set(false, forKey: "loginState")
    }
}

func updateUserInfo(after: @escaping () -> ()) {
    UserApi.shared.me() {(user, error) in
        if let error = error {
            print(error)
        }
        else {
            print("me() success.")
            
            //do something
            _ = user
            after()
        }
    }
}

func afterLogin() {
    let mainTabView = MainTabBarViewController()
    UserDefaults.standard.set(true, forKey: "loginState")
    updateUserInfo(after: {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(mainTabView, animated: true)
    })
}
