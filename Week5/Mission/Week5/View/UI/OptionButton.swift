//
//  RadioButton.swift
//  Week5
//
//  Created by 정재욱 on 10/30/23.
//

import UIKit
enum OptionBtnStyle {
    case radio, checkbox
}

class OptionButton: UIButton {
    var optionStyle: OptionBtnStyle = .radio
    
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                optionImageView.image = (optionStyle == .checkbox) ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "dot.circle.fill")
                optionImageView.tintColor = .accent
            } else {
                optionImageView.image = (optionStyle == .checkbox) ? UIImage(systemName: "square") : UIImage(systemName: "circle")
                optionImageView.tintColor = .lightGray
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        addSubview(optionImageView)
        addSubview(stackView)
        stackView.addArrangedSubview(optionLabel)
        stackView.addArrangedSubview(priceLabel)
        
        autoLayout()
    }
    
    //MARK: init View
    
    private let optionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor  .constraint(equalToConstant: 24).isActive = true
        imageView.widthAnchor   .constraint(equalToConstant: 24).isActive = true
        imageView.image = UIImage(systemName: "circle")
        imageView.tintColor = .lightGray
        return imageView
    } ()
    
    private let optionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "옵션 명"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    } ()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "12,000원"
        return label
    } ()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.isUserInteractionEnabled = false
        stackView.distribution = .equalSpacing
        return stackView
    } ()
    
    //MARK: Getter Setter
    var optionText: String? {
        didSet { optionLabel.text = optionText }
    }
    
    var priceText: Int? {
        didSet { priceLabel.text = convertNumberToString(price: priceText!) + "원" }
    }
    
    var image: UIImage? {
        didSet { optionImageView.image = image}
    }
    
    var imgColor: UIColor? {
        didSet { optionImageView.tintColor = imgColor}
    }
    
    //MARK: UI Layout Init
    func autoLayout() {
        stackView.leadingAnchor.constraint(equalTo: optionImageView.trailingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        optionImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        optionImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        
//        optionLabel.leadingAnchor.constraint(equalTo: radioImageView.trailingAnchor, constant: 8).isActive = true
//        optionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        optionLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor).isActive = true
//        
//        priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
//        priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
