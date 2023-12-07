//
//  FeedUploadDataManager.swift
//  Codebase
//
//  Created by 정재욱 on 12/6/23.
//

import Alamofire
import UIKit

class FeedUploadDataManager {
    let header: HTTPHeaders = ["content-Type": "multipart/form-data", "Authorization": UserDefaults.standard.string(forKey: "authKey")!]

    func posts(_ viewController: FeedViewController, _ parameter: FeedUploadInput, _ attachment: UIImage) {
        AF.upload(multipartFormData: { multipart in
            if let imageData = attachment.jpegData(compressionQuality: 0.5) {
                multipart.append(imageData, withName: "attachment",fileName: "\(imageData).jpg", mimeType: "image/jpeg")
            }
            multipart.append(Data(parameter.content?.utf8 ?? "".utf8), withName: "content")
        }, to: "http://catstagram.jeuke.com:8080/posts", method: .post, headers: header).responseDecodable(of: FeedUploadModel.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSuccess{
                    print(result.message)
                } else {
                    print(result.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
