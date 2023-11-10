//
//  CartViewController.swift
//  Week5
//
//  Created by 정재욱 on 10/31/23.
//

import UIKit

class CartViewController: UIViewController {
    var selectedMenu: DataForSend?
    
    var  delegate: SendData?

    lazy var storeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    lazy var menuNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    lazy var selectedOptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.tintColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    lazy var cartTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(cartTableView)
        // Do any additional setup after loading the view.
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        cartTableView.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.identifier)
        
        setLayout()
    }
    
    func setLayout() {
        cartTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        cartTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        cartTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        cartTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            delegate?.send(dataForSend: selectedMenu!)
        }
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedMenu?.menus.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        cell.menuNameLabel.text = selectedMenu?.menus[indexPath.row].menuTitle
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(cellButtonTapped(_:)), for: .touchUpInside)
        
        var totalPrice = 0
        
        cell.optionStackView.clearSubviews()
        for optionGroup in selectedMenu!.menus[indexPath.row].optionGroups {
            if optionGroup.options.count == 0 {
                continue
            }
            let optionLabel = UILabel()
            var labelText = "· \(optionGroup.groupTitle) : "
            for (index, option) in optionGroup.options.enumerated() {
                labelText += "\(option.optionTitle) (\(convertNumberToString(price: option.price))원)"
                if index < optionGroup.options.count - 1 {
                    labelText += " / "
                }
                totalPrice += option.price
            }
            optionLabel.text = labelText
            
            let thirdParagraphStyle = NSMutableParagraphStyle()
            thirdParagraphStyle.firstLineHeadIndent = 0
            thirdParagraphStyle.headIndent = 10
            optionLabel.attributedText = NSAttributedString(string: labelText, attributes: [NSAttributedString.Key.paragraphStyle: thirdParagraphStyle])
            
            optionLabel.textColor = .lightGray
            optionLabel.font = UIFont.systemFont(ofSize: 14)
            optionLabel.numberOfLines = 0
            
            cell.optionStackView.addArrangedSubview(optionLabel)
        }
        
        cell.priceLabel.text = convertNumberToString(price: totalPrice) + "원"
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CartViewController: ButtonTappedDelegate {
    @objc
    func cellButtonTapped(_ sender: UIButton) {
        selectedMenu?.menus.remove(at: sender.tag)
        
        cartTableView.reloadData()
    }
}

extension CartViewController: SendData{
    func send(dataForSend: DataForSend) {
        self.selectedMenu = dataForSend
    }
}

protocol SendData {
    func send(dataForSend: DataForSend)
}
