//
//  UserFeedDataManager.swift
//  Codebase
//
//  Created by 정재욱 on 12/7/23.
//

import Alamofire
import Foundation

class UserFeedDataManager {
    let header: HTTPHeaders = ["Authorization": UserDefaults.standard.string(forKey: "authKey")!]
    
    func getUserFeed(_ viewController: ProfileViewController) {
        AF.request("http://catstagram.jeuke.com:8080/users/me", method: .get, headers: header).validate().responseDecodable(of: UserFeedModel.self) { response in
            switch response.result {
            case .success(let result):
                viewController.successFeedAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteUserFeed(_ viewController: ProfileViewController, _ postID: String) {
        AF.request("http://catstagram.jeuke.com:8080/posts/\(postID)", method: .delete, headers: header).validate().responseDecodable(of: DeleteUserFeed.self) { response in
            switch response.result {
            case .success(let result):
                print("Debug: \(result)")
                viewController.successDeletePostAPI(result.isSuccess ?? false)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
