//
//  ViewController.swift
//  Week5
//
//  Created by 정재욱 on 10/28/23.
//

import UIKit

struct DataForSend {
    var storeName: String
    var menus: [Menu]
}

struct SelectedMenu {
    var menuTitle: String
    var optionGroups: [OptionGroup]
}

class MenuViewController: UIViewController {
    var dataForSend : DataForSend = DataForSend(storeName: data.storeName, menus: [])
    
    var selectedMenu: Menu = data.menus[0]

    @IBOutlet weak var optionsTableView: UITableView!
    
    var delegate: SendData?
    
    lazy var optionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for index in selectedMenu.optionGroups.indices {
            if selectedMenu.optionGroups[index].isRequired {
                selectedMenu.optionGroups[index].options = [selectedMenu.optionGroups[index].options[0]]
            } else {
                selectedMenu.optionGroups[index].options = []
            }
        }
        
        self.navigationController?.navigationBar.topItem?.title = selectedMenu.menuTitle
        
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        
        optionsTableView.register(SelectGroupTableViewCell.self, forCellReuseIdentifier: SelectGroupTableViewCell.identifier)
    }
    
    
    @IBAction func cartButtonDidTap(_ sender: Any) {
        dataForSend.menus.append(selectedMenu)
        let cartViewController = CartViewController()
        cartViewController.modalPresentationStyle = .fullScreen
        cartViewController.selectedMenu = self.dataForSend
        cartViewController.delegate = self
        self.navigationController?.pushViewController(cartViewController, animated: true)
    }
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.menus[0].optionGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = optionsTableView.dequeueReusableCell(withIdentifier: SelectGroupTableViewCell.identifier, for: indexPath) as! SelectGroupTableViewCell
        cell.gruopTitleLabel.text = data.menus[0].optionGroups[indexPath.row].groupTitle
        if data.menus[0].optionGroups[indexPath.row].isRequired {
            cell.maxSelectLabel.isHidden = true
        } else {
            cell.maxSelectLabel.isHidden = false
            cell.maxSelectLabel.text = "최대 \(data.menus[0].optionGroups[indexPath.row].maxChoice)개 선택"
        }
        cell.delegate = self
        
        cell.optionStackView.clearSubviews()
        if data.menus[0].optionGroups[indexPath.row].isRequired {
            for option in data.menus[0].optionGroups[indexPath.row].options {
                let radioBtn = OptionButton()
                radioBtn.tag = indexPath.row
                radioBtn.optionStyle = .radio
                radioBtn.isChecked = (selectedMenu.optionGroups[indexPath.row].options.firstIndex(where: {$0.optionTitle == option.optionTitle}) != nil)
                radioBtn.optionText = option.optionTitle
                radioBtn.priceText = option.price
                radioBtn.addTarget(self, action: #selector(cellButtonTapped(_:)), for: .touchUpInside)
                cell.optionStackView.addArrangedSubview(radioBtn)
            }
        } else {
            for option in data.menus[0].optionGroups[indexPath.row].options {
                let radioBtn = OptionButton()
                radioBtn.tag = indexPath.row
                radioBtn.optionStyle = .checkbox
                radioBtn.isChecked = (selectedMenu.optionGroups[indexPath.row].options.firstIndex(where: {$0.optionTitle == option.optionTitle}) != nil)
                radioBtn.optionText = option.optionTitle
                radioBtn.priceText = option.price
                radioBtn.addTarget(self, action: #selector(cellButtonTapped(_:)), for: .touchUpInside)
                cell.optionStackView.addArrangedSubview(radioBtn)
            }
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MenuViewController: OptionTappedDelegate {
    @objc
    func cellButtonTapped(_ sender: OptionButton) {
        
        let indexValue = selectedMenu.optionGroups[sender.tag].options.firstIndex(where: {$0.optionTitle == sender.optionText})
        if selectedMenu.optionGroups[sender.tag].isRequired {
            selectedMenu.optionGroups[sender.tag].options = [Option(optionTitle: sender.optionText!, price: sender.priceText!)]
            optionsTableView.reloadData()
        } else {
            if sender.isChecked {
                selectedMenu.optionGroups[sender.tag].options.remove(at: indexValue!)
                optionsTableView.reloadData()
            } else {
                if selectedMenu.optionGroups[sender.tag].maxChoice > selectedMenu.optionGroups[sender.tag].options.count {
                    selectedMenu.optionGroups[sender.tag].options.append(Option(optionTitle: sender.optionText!, price: sender.priceText!))
                    optionsTableView.reloadData()
                }
            }
        }
    }
}

extension UIStackView {
    func clearSubviews() {
        self.arrangedSubviews.forEach { view in
            self.removeArrangedSubview(view) // 부모뷰에서도 자식 뷰를 지워주고
            view.removeFromSuperview() // 자식 뷰에서도 부모 뷰를 지워준다
        }
    }
}

extension MenuViewController: SendData{
    func send(dataForSend: DataForSend) {
        self.dataForSend = dataForSend
    }
}

