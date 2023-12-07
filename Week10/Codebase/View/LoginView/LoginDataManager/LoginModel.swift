//
//  LoginModel.swift
//  Codebase
//
//  Created by 정재욱 on 12/7/23.
//

struct LoginInput: Codable {
    let email: String
    let password: String
}

struct LoginModel: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: LoginResult?
}

struct LoginResult: Codable {
    let token: String?
}
