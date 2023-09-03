//
//  SimilarTableViewCell.swift
//  Media
//
//  Created by 이은서 on 2023/08/27.
//

import UIKit

class SimilarTableViewCell: UITableViewCell {

    static let identifier = "SimilarTableViewCell"
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var linkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.textAlignment = .left
        linkLabel.font = .systemFont(ofSize: 14)
        titleLabel.textAlignment = .left
    }


}
