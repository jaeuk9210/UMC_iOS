//
//  PostCollectionViewCell.swift
//  Codebase
//
//  Created by 정재욱 on 11/13/23.
//

import UIKit

import SnapKit

class PostCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "PostCollectionViewCell"
    
    private lazy var postImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemIndigo
        return imageView
    } ()
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) hs not been implemented")
    }
    
    //MARK: - Actions
    
    //MARK: - Helpers
    private func setup() {
        addViews()
        setAutoLayout()
    }
    
    private func addViews() {
        contentView.addSubview(postImageView)
    }

    private func setAutoLayout() {
        postImageView.snp.makeConstraints{
            $0.edges.equalTo(contentView)
        }
    }
    
    public func setupData() {
        //TODO: 이미지뷰의 이미지를 로딩
    }
}
