//
//  UserFeedModel.swift
//  Codebase
//
//  Created by 정재욱 on 12/7/23.
//

struct UserFeedModel: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: UserFeedResult?
}

struct UserFeedResult: Codable {
    let userInfo: UserFeedUserInfo?
    let userPosts: [UserFeedUserPost]?
}

struct UserFeedUserInfo: Codable {
    let username: String?
    let id: String?
    let name: String?
    let postfileImgUrl: String?
    let website: String?
    let introduction: String? 
    let followerCount: Int?
    let followingCount: Int?
    let postCount: Int?
}

struct UserFeedUserPost: Codable {
    let _id: String?
    let postImgURL: String?
}
