//
//  ViewController.swift
//  Week3
//
//  Created by 정재욱 on 10/2/23.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLeftButtonsToNavigationBar()
        addRightButtonsToNavigationBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
        tableView.register(RecommendTableViewCell.self, forCellReuseIdentifier: "RecommendTableViewCell")
    }
    
    // MARK: Navigation Button Settings
    
    func addLeftButtonsToNavigationBar() {
        let locationBtn: UIBarButtonItem = {
            lazy var config = UIButton.Configuration.plain()
            
            config.title = "사동"
            config.imagePlacement = .trailing
            config.imagePadding = 5
            config.image = UIImage(systemName:"chevron.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 10, weight: .black))
            config.baseForegroundColor = .black
            
            let button = UIButton(configuration: config)
            
            return UIBarButtonItem(customView:button)
        } ()
        
        navigationItem.leftBarButtonItem = locationBtn
    }
    
    func addRightButtonsToNavigationBar() {
        let menuBtn: UIBarButtonItem = {
            let button = CSRightBarButton.init(type: .custom)
            button.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
            return UIBarButtonItem(customView:button)
        } ()
        
        let searchBtn: UIBarButtonItem = {
            let button = CSRightBarButton.init(type: .custom)
            button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            return UIBarButtonItem(customView:button)
        } ()
        
        let notiBtn: UIBarButtonItem = {
            let button = CSRightBarButton.init(type: .custom)
            button.setImage(UIImage(systemName: "bell"), for: .normal)
            return UIBarButtonItem(customView:button)
        } ()
        
        navigationItem.rightBarButtonItems = [notiBtn, searchBtn, menuBtn]
    }

}

// MARK: TableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendTableViewCell", for: indexPath) as? RecommendTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.contentView.isUserInteractionEnabled = false;
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
            let post  = data[indexPath.row]
            
            let split = " · "
            let repost = (post.rePost ? "끌올 " : "")
            
            cell.selectionStyle = .none
            
            cell.postImageView.imageDownload(url: URL(string:data[indexPath.row].imageURL)!, key: String(indexPath.row))
            
            cell.titleLabel.text = post.title
            cell.locationAndTimeLabel.text = post.location + split + repost + calcTimeDiff(date: post.time)
            
            if post.price == nil {
                cell.priceLabel.isHidden = true
            } else {
                if post.isShare {
                    cell.priceLabel.text = "나눔🧡"
                } else {
                    cell.priceLabel.text = convertNumberToString(price:post.price!) + "원"
                }
            }
            
            if post.comment == nil || post.comment == 0 {
                cell.commentView.isHidden = true
            } else {
                cell.commentLabel.text = String(post.comment!)
            }
            
            if post.like == nil || post.like == 0 {
                cell.likeView.isHidden = true
            } else {
                cell.likeLabel.text = String(post.like!)
            }
            
            if post.isReservation == false {
                cell.reservationBadge.isHidden = true
            }
            
            if post.isDone == false {
                cell.doneBadge.isHidden = true
            } else if post.isShare {
                cell.doneBadge.text = "나눔완료"
            }
            
            cell.contentView.isUserInteractionEnabled = false;
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? RecommendTableViewCell else {
            return
        }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return 230
        }
        return UITableView.automaticDimension
    }
}

// MARK: CollectionView
extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as? RecommendCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let post  = data[indexPath.row]
        cell.postImageView.imageDownload(url: URL(string:data[indexPath.row].imageURL)!, key: String(indexPath.row))
        cell.titleLabel.text = post.title
        cell.priceLabel.text = convertNumberToString(price:post.price!) + "원"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 108, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected \(indexPath.row)")
    }
}

extension UIImageView {
    func imageDownload(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, key: String) {
        if let cacheImage = Cache.imageCache.object(forKey: key as NSString) {
            DispatchQueue.main.async() { [weak self] in
                self?.contentMode = mode
                self?.image = cacheImage
            }
        }
        else {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else {
                        print("Download image fail : \(url)")
                        return
                }

                DispatchQueue.main.async() { [weak self] in
                    print("Download image success \(url)")
                    print(key)

                    Cache.imageCache.setObject(image, forKey: key as NSString)

                    self?.contentMode = mode
                    self?.image = image
                }
            }.resume()
        }
    }
}

class Cache {
    static let imageCache = NSCache<NSString, UIImage>()
}
