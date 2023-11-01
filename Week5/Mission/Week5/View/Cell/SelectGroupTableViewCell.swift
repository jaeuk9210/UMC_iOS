//
//  RadioGroupTableViewCell.swift
//  Week5
//
//  Created by 정재욱 on 10/28/23.
//

import UIKit

@objc
protocol OptionTappedDelegate : AnyObject {
    func cellButtonTapped(_ sender: OptionButton)
}

class SelectGroupTableViewCell: UITableViewCell {
    static let identifier = "RadioGroupTableViewCell"
    
    weak var delegate: OptionTappedDelegate?

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
        contentView.addSubview(titleStackView)
        titleStackView.addArrangedSubview(gruopTitleLabel)
        titleStackView.addArrangedSubview(maxSelectLabel)
        contentView.addSubview(optionStackView)
        
        autoLayout()
    }

    //MARK: UI Init
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    } ()
    
    lazy var gruopTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    } ()
    
    lazy var maxSelectLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        return label
    } ()
    
    lazy var optionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    } ()
    
    //MARK: UI Layout Init
    func autoLayout() {
        titleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        
        optionStackView.topAnchor.constraint(equalTo: maxSelectLabel.bottomAnchor, constant: 20).isActive = true
        optionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        optionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        optionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}
