//
//  KakaoAuthViewModel.swift
//  Codebase
//
//  Created by 정재욱 on 11/16/23.
//

import Foundation
import UIKit
import Combine

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class KakaoAuthViewModel: ObservableObject {

    var subscription = Set<AnyCancellable>()

    @Published var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "loginState")
    @Published var user: User?

    lazy var profileImageURL: AnyPublisher<URL?, Never> = $user.compactMap {
        return $0?.kakaoAccount?.profile?.profileImageUrl
    }.eraseToAnyPublisher()

    lazy var username: AnyPublisher<String?, Never> = $user.compactMap {
        return $0?.kakaoAccount?.profile?.nickname
    }.eraseToAnyPublisher()
    
    lazy var userEmail: AnyPublisher<String?, Never> = $user.compactMap{
        return $0?.kakaoAccount?.email
    }.eraseToAnyPublisher()

    init() {
        print("KakaoAuthVM - init() colled")
    }

    func handleKakaoLoginWithApp() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }

        }
    }

    func handleKakaoLoginWithAccount() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoAccount() success.")

                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }

    func handleKakaoLogout() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.logout { (error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
    }

    func handleKakaoUserInfo() async -> User? {
        await withCheckedContinuation { continuation in
            UserApi.shared.me() { (user, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: nil)
                }
                else {
                    print("me() success.")

                    //do something
                    _ = user
                    continuation.resume(returning: user)
                }
            }
        }
    }

    @MainActor
    func kakaoLogin() {
        print("KakaoAuthVM - handleKakaoLogin() colled")
        Task {
            if (UserApi.isKakaoTalkLoginAvailable()) { //카카오톡 설치 되어 있음
                isLoggedIn = await handleKakaoLoginWithApp()
            } else { //카카오톡이 설치되어 있지 않음
                isLoggedIn = await handleKakaoLoginWithAccount()
            }
        }
    }

    @MainActor
    func kakaoLogout() {
        Task {
            if await handleKakaoLogout() {
                self.isLoggedIn = false
                let loginVC = LoginViewController()
                UserDefaults.standard.set(false, forKey: "loginState")
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(loginVC, animated: true)
            }
        }
    }

    @MainActor
    func getUserInfo() {
        Task {
            user = await handleKakaoUserInfo()
        }
    }
}

