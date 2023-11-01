//
//  CartTableViewCell.swift
//  Week5
//
//  Created by 정재욱 on 11/1/23.
//

import UIKit

@objc
protocol ButtonTappedDelegate : AnyObject {
    func cellButtonTapped(_ sender: UIButton)
}

class CartTableViewCell: UITableViewCell {
    static let identifier = "CartTableViewCell"
    
    weak var delegate: ButtonTappedDelegate?
    
    var index: Int = 0

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup() {
        contentView.addSubview(menuNameLabel)
        contentView.addSubview(deleteBtn)
        contentView.addSubview(optionStackView)
        contentView.addSubview(priceLabel)
        
        autoLayout()
    }

    //MARK: UI Init
    lazy var menuNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    } ()
    
    lazy var deleteBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    } ()
    
    lazy var optionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    } ()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    } ()
    
    //MARK: UI Layout Init
    func autoLayout() {
        menuNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        menuNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        
        deleteBtn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        deleteBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        optionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        optionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        optionStackView.topAnchor.constraint(equalTo: menuNameLabel.bottomAnchor, constant: 10).isActive = true
        
        priceLabel.leadingAnchor.constraint(equalTo: optionStackView.leadingAnchor).isActive = true
        priceLabel.topAnchor.constraint(equalTo: optionStackView.bottomAnchor, constant: 10).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
    }
}
