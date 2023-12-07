//
//  RegisterModel.swift
//  Codebase
//
//  Created by 정재욱 on 12/7/23.
//

struct RegisterInput: Codable {
    let email: String
    let password: String
    let name: String
    let username: String
}

struct RegisterModel: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: RegisterResult?
}

struct RegisterResult: Codable {
    let user: RegisterResultUser?
}

struct RegisterResultUser: Codable {
    let id: String?
    let email: String?
}
