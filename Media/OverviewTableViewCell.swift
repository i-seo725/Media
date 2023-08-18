//
//  OverviewTableViewCell.swift
//  Media
//
//  Created by 이은서 on 2023/08/15.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    static let identifier = "OverviewTableViewCell"
    
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var expandButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
