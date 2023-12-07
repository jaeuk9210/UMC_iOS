//
//  FeedUploadModel.swift
//  Codebase
//
//  Created by 정재욱 on 12/6/23.
//

struct FeedUploadModel: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: String?
}
