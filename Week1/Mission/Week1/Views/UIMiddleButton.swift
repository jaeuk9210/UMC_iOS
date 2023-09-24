//
//  UIMiddleButton.swift
//  Week1
//
//  Created by 정재욱 on 2023/09/24.
//

import UIKit

@IBDesignable class UIMiddleButton: UIButton {
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 0
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    private let backgroundImg: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        return view
    } ()
    
    private let btnTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "배달"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        return label
    } ()
    
    private let btnSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "세상은 넓고\n맛집은 많다"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    } ()
    
    @IBInspectable var buttonTitleText: String = "Button" {
        didSet{
            btnTitleLabel.text = buttonTitleText
        }
    }
    
    @IBInspectable var subButtonTitleText: String = "attribute" {
        didSet{
            btnSubTitleLabel.text = subButtonTitleText
        }
    }
    
    @IBInspectable var backImg: UIImage = UIImage(){
        didSet{
            updateStateUI()
        }
    }
    
    @IBInspectable var labelSize: CGFloat = CGFloat(12.0){
        didSet{
//            label.font = label.font.withSize(labelSize)
        }
    }
    
    private func updateStateUI() {
        btnTitleLabel.alpha = 1
        btnSubTitleLabel.alpha = 1
        backgroundImg.image = backImg
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUp()
    }
    
    private func setUp() {
        addSubview(stackView)
        self.layer.cornerRadius = 6
        self.layer.shadowOpacity = 0.1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 1
        self.layer.backgroundColor = UIColor.white.cgColor
        
        [btnTitleLabel, btnSubTitleLabel, backgroundImg].forEach(stackView.addArrangedSubview(_:))

        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
}
