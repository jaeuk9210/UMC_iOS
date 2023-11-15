//
//  ImageViewExtensioin.swift
//  Codebase
//
//  Created by 정재욱 on 11/16/23.
//

import UIKit

extension UIImageView {
    func imageDownload(url: URL?, contentMode mode: UIView.ContentMode = .scaleAspectFit, key: String?) {
        if url != nil && key != nil {
            if let cacheImage = Cache.imageCache.object(forKey: key! as NSString) {
                DispatchQueue.main.async() { [weak self] in
                    self?.contentMode = mode
                    self?.image = cacheImage
                }
            }
            else {
                var request = URLRequest(url: url!)
                request.httpMethod = "GET"
                
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard
                        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                        let data = data, error == nil,
                        let image = UIImage(data: data)
                    else {
                        print("Download image fail : \(url!)")
                        return
                    }
                    
                    DispatchQueue.main.async() { [weak self] in
                        print("Download image success \(url!)")
                        print(key!)
                        
                        Cache.imageCache.setObject(image, forKey: key! as NSString)
                        
                        self?.contentMode = mode
                        self?.image = image
                    }
                }.resume()
            }
        }
    }
}

class Cache {
    static let imageCache = NSCache<NSString, UIImage>()
}

