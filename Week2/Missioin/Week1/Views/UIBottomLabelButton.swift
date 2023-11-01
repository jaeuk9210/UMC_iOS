//
//  UIBottomLabelButton.swift
//  Week1
//
//  Created by 정재욱 on 2023/09/24.
//

import UIKit

@IBDesignable class UIBottomLabelButton: UIButton {
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 5
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    private let iconImg: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        return view
    } ()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "button"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    @IBInspectable var buttonText: String = "Button" {
        didSet{
            label.text = buttonText
        }
    }
    
    @IBInspectable var buttonImage: UIImage = UIImage(){
        didSet{
            updateStateUI()
        }
    }
    
    @IBInspectable var labelSize: CGFloat = CGFloat(12.0){
        didSet{
            label.font = label.font.withSize(labelSize)
        }
    }
    
    private func updateStateUI() {
        label.alpha = 1
        iconImg.image = buttonImage
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
        [iconImg, label].forEach(stackView.addArrangedSubview(_:))

        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            iconImg.heightAnchor.constraint(equalTo: iconImg.widthAnchor, multiplier: 1.0/1.0)
        ])
    }
}
