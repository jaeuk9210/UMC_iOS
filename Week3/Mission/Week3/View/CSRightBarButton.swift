//
//  CSRightBarButton.swift
//  Week3
//
//  Created by 정재욱 on 10/2/23.
//

import UIKit

class CSRightBarButton: UIButton {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: 33, height: 33)
        self.tintColor = .black
    }
}
