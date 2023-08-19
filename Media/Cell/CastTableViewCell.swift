//
//  CastTableViewCell.swift
//  Media
//
//  Created by 이은서 on 2023/08/13.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    static let identifier = "CastTableViewCell"
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var characterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = 8
        profileImageView.layer.shadowOpacity = 0.6
        profileImageView.layer.shadowRadius = 1
        
        nameLabel.font = .boldSystemFont(ofSize: 15)
        characterLabel.font = .systemFont(ofSize: 14)
        characterLabel.textColor = .darkGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
