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
//    @IBOutlet var expandButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
//        expandButton.setTitle("", for: .normal)
//        expandButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        contentsLabel.font = .systemFont(ofSize: 14)
        
    }


}
