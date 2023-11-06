//
//  FeedTableViewCell.swift
//  Week5_Study
//
//  Created by 정재욱 on 11/6/23.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewFeed: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var buttonisHeart: UIButton!
    @IBOutlet weak var buttonisBookmark: UIButton!
    @IBOutlet weak var imageViewUserProfile: UIImageView!
    @IBOutlet weak var labelHowManyLike: UILabel!
    @IBOutlet weak var labelFeed: UILabel!
    @IBOutlet weak var imageViewMyProfile: UIImageView!
    
    @IBAction func actionIsHeart(_ sender: Any) {
        if buttonisHeart.isSelected {
            buttonisHeart.isSelected = false
        } else {
            buttonisHeart.isSelected = true
        }
    }
    
    @IBAction func actionBookmark(_ sender: Any) {
        if buttonisBookmark.isSelected {
            buttonisBookmark.isSelected = false
        } else {
            buttonisBookmark.isSelected = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageViewUserProfile.layer.cornerRadius = 12.5
        imageViewUserProfile.clipsToBounds = true
        
        imageViewMyProfile.layer.cornerRadius = 12.5
        imageViewMyProfile.clipsToBounds = true
        
        let fontSize = UIFont.boldSystemFont(ofSize: 9)
        let attributeStr = NSMutableAttributedString(string: labelFeed.text ?? "")
        attributeStr.addAttribute(.font, value: fontSize, range: NSRange.init(location: 0, length: 3))
        
        labelFeed.attributedText = attributeStr
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
