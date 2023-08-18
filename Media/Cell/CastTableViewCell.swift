//
//  CastTableViewCell.swift
//  Media
//
//  Created by 이은서 on 2023/08/13.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    static let identifier = "CastTableViewCell"
    
    @IBOutlet var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
