//
//  FeedUploadInput.swift
//  Codebase
//
//  Created by 정재욱 on 12/6/23.
//

import Foundation

struct FeedUploadInput: Codable {
    var content: String?
    
    enum CodingKeys: String, CodingKey {
        case content
    }
}
