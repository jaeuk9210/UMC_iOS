//
//  FeedDataManager.swift
//  Codebase
//
//  Created by 정재욱 on 11/16/23.
//

import Alamofire

class FeedDataManager {
    func feedDataManager(_ parameters: FeedAPIInput, _ viewController: FeedViewController) {
        AF.request("https://api.thecatapi.com/v1/images/search", method: .get, parameters: parameters).validate().responseDecodable(of: [FeedModel].self) { response in
            switch response.result {
            case .success(let result):
                print("성공")
                viewController.successAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
