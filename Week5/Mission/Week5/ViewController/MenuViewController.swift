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

private enum Metric {
  static let headerHeight = 250.0
}

class MenuViewController: UIViewController {
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.imageDownload(url: URL(string: data.menus[0].imageURL ?? "")!, contentMode: UIView.ContentMode.scaleAspectFill , key: data.menus[0].menuTitle)
        return imageView
    } ()
    private var headerHeightConstraint: NSLayoutConstraint?
    
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
        view.addSubview(topImageView)
        
        for index in selectedMenu.optionGroups.indices {
            if selectedMenu.optionGroups[index].isRequired {
                selectedMenu.optionGroups[index].options = [selectedMenu.optionGroups[index].options[0]]
            } else {
                selectedMenu.optionGroups[index].options = []
            }
        }
        
        setAutoLayout()
        
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
    
    func setAutoLayout() {
        optionsTableView.contentInset = .init(top: Metric.headerHeight, left: 0, bottom: 0, right: 0)
        optionsTableView.backgroundColor = .clear
        
        headerHeightConstraint = topImageView.heightAnchor.constraint(equalToConstant: Metric.headerHeight)
        headerHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            topImageView.topAnchor.constraint(equalTo: view.topAnchor),
            topImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let constraint = headerHeightConstraint else {return}
        
        let remainingTopSpacing = abs(scrollView.contentOffset.y)
        let lowerThanTop = scrollView.contentOffset.y < 0 - Double(view.safeAreaInsets.top)
        let stopExpandHeaderHeight = scrollView.contentOffset.y > -(Metric.headerHeight)
        
        if stopExpandHeaderHeight, lowerThanTop {
            // 1) 초기 상태: UIImageView가 지정한 크기만큼 커졌고, 스크롤뷰의 시작점이 최상단보다 아래 존재
            optionsTableView.contentInset = .init(top: remainingTopSpacing, left: 0, bottom: 0, right: 0)
            constraint.constant = remainingTopSpacing
            topImageView.alpha = remainingTopSpacing / Metric.headerHeight
            view.layoutIfNeeded()

            self.navigationController?.navigationBar.topItem?.title = selectedMenu.menuTitle
        } else if !lowerThanTop {
            // 2) 스크롤 뷰의 시작점이 최상단보다 위에 존재
            optionsTableView.contentInset = .zero
            constraint.constant = 0
            topImageView.alpha = 0
            self.navigationController?.navigationBar.topItem?.title = selectedMenu.menuTitle
            
        } else {
            // 3) 스크롤 뷰의 시작점이 최상단보다 밑에 있고, 스크롤뷰 상단 contentInset이 미리 지정한 UIImageView 높이인, Metric.headerHeight보다 큰 경우
            constraint.constant = remainingTopSpacing
            topImageView.alpha = 1
            self.navigationController?.navigationBar.topItem?.title = ""
        }
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

extension MenuViewController: SendData{
    func send(dataForSend: DataForSend) {
        self.dataForSend = dataForSend
    }
}

