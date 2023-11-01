//
//  NavigationController.swift
//  Week1
//
//  Created by 정재욱 on 2023/09/24.
//

import UIKit

class HomeViewController: UIViewController {
    private let locationBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        button.setTitle("우리집", for: .normal)
        button.tintColor = .white
        button.setImage(UIImage(systemName:"arrowtriangle.down.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 10)), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: locationBtn)
    }
}
