//
//  HomeTableViewCell.swift
//  Week3
//
//  Created by 정재욱 on 10/3/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius                        = 6
        imageView.clipsToBounds                             = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.heightAnchor.constraint(equalToConstant: 108).isActive                            = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.0).isActive = true
        imageView.backgroundColor = .lightGray
        return imageView
    } ()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text                                      = "글 제목"
        label.textAlignment                             = .left
        label.font                                      = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor                                 = .black
        label.numberOfLines                             = 2
        label.lineBreakMode                             = .byCharWrapping
        return label
    } ()
    
    lazy var locationAndTimeLabel: UILabel = {
        let label = UILabel()
        label.text                                      = "강남구"
        label.textAlignment                             = .left
        label.font                                      = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor                                 = .lightGray
        return label
    } ()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text                                      = "0원"
        label.textAlignment                             = .left
        label.font                                      = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor                                 = .black
        return label
    } ()
    
    lazy var contentsView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis      = .vertical
        stackView.spacing   = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    lazy var tableCell: UIStackView = {
        let stackView = UIStackView()
        stackView.axis      = .horizontal
        stackView.spacing   = 16
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.text                                      = "1"
        label.font                                      = UIFont.systemFont(ofSize: 12)
        label.textColor                                 = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    lazy var reservationBadge: CSPaddingLabel = {
        let label = CSPaddingLabel(padding: UIEdgeInsets(top: 5.0, left: 7.0, bottom: 5.0, right: 7.0))
        
        label.text = "예약중"
        label.cornerRadius = 3
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .white
        label.backgroundColor = UIColor(red: 26/255, green: 162/255, blue: 116/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        let width = (label.text! as NSString).size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10, weight: .bold)]).width
        label.widthAnchor.constraint(equalToConstant: width+14).isActive = true
        return label
    } ()
    
    lazy var doneBadge: CSPaddingLabel = {
        let label = CSPaddingLabel(padding: UIEdgeInsets(top: 5.0, left: 7.0, bottom: 5.0, right: 7.0))
        
        label.text = "거래완료"
        label.cornerRadius = 3
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .white
        label.backgroundColor = UIColor(red: 77/255, green: 81/255, blue: 90/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        let width = (label.text! as NSString).size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10, weight: .bold)]).width
        label.widthAnchor.constraint(equalToConstant: width+14).isActive = true
        return label
    } ()
    
    lazy var priceStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis      = .horizontal
        stackView.spacing   = 5
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    lazy var commentView: UIView = {
        let view = UIView()
        
        let image = UIImageView(image: UIImage(systemName: "message"))
        view.addSubview(image)
        
        view.translatesAutoresizingMaskIntoConstraints      = false
        image.translatesAutoresizingMaskIntoConstraints     = false
        
        image.heightAnchor.constraint(equalToConstant: 16).isActive             = true
        image.widthAnchor.constraint(equalToConstant: 16).isActive              = true
        image.topAnchor.constraint(equalTo: view.topAnchor).isActive            = true
        image.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive    = true
        image.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive      = true
        image.tintColor = .darkGray
        
        view.addSubview(commentLabel)
        commentLabel.centerYAnchor.constraint(equalTo: image.centerYAnchor).isActive = true
        commentLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 3).isActive = true
        commentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        return view
    } ()
    
    lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.text                                      = "1"
        label.font                                      = UIFont.systemFont(ofSize: 12)
        label.textColor                                 = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    lazy var likeView: UIView = {
        let view = UIView()
        
        let image = UIImageView(image: UIImage(systemName: "heart"))
        view.addSubview(image)
        
        view.translatesAutoresizingMaskIntoConstraints      = false
        image.translatesAutoresizingMaskIntoConstraints     = false
        
        image.heightAnchor.constraint(equalToConstant: 16).isActive             = true
        image.widthAnchor.constraint(equalToConstant: 16).isActive              = true
        image.topAnchor.constraint(equalTo: view.topAnchor).isActive            = true
        image.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive    = true
        image.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive      = true
        image.tintColor = .darkGray
        
        view.addSubview(likeLabel)
        likeLabel.centerYAnchor.constraint(equalTo: image.centerYAnchor).isActive = true
        likeLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 3).isActive = true
        likeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        return view
    } ()
    
    lazy var commentAndLikeStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis      = .horizontal
        stackView.spacing   = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    func setContentsView() {
        contentsView.addArrangedSubview(titleLabel)
        contentsView.addArrangedSubview(locationAndTimeLabel)
        contentsView.addArrangedSubview(priceStack)
    }
    
    func setTableCell() {
        tableCell.addArrangedSubview(postImageView)
        tableCell.addArrangedSubview(contentsView)
    }
    
    func setCommentAndLikeView() {
        commentAndLikeStack.addArrangedSubview(commentView)
        commentAndLikeStack.addArrangedSubview(likeView)
    }
    
    func setPriceView() {
        priceStack.addArrangedSubview(reservationBadge)
        priceStack.addArrangedSubview(doneBadge)
        priceStack.addArrangedSubview(priceLabel)
    }
    
    func setup() {
        addSubview(tableCell)
        
        tableCell.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive               = true
        tableCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive        = true
        tableCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive       = true
        tableCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive    = true
                

        setContentsView()
        setPriceView()
        setTableCell()
        setCommentAndLikeView()
        
        addSubview(commentAndLikeStack)
        commentAndLikeStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive     = true
        commentAndLikeStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not  been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
