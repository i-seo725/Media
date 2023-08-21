//
//  RecommendationTableViewCell.swift
//  Media
//
//  Created by 이은서 on 2023/08/21.
//

import UIKit

class RecommendationTableViewCell: UITableViewCell {

    static let identifier = "RecommendationTableViewCell"
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImageView.alpha = 0.6
        backgroundImageView.contentMode = .scaleAspectFill
        posterImageView.layer.shadowColor = UIColor.black.cgColor
        
        posterImageView.clipsToBounds = false
        posterImageView.layer.shadowRadius = 1
        posterImageView.layer.shadowOpacity = 0.6
        posterImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white
        
        releaseLabel.font = .boldSystemFont(ofSize: 15)
        releaseLabel.textColor = .white
    }

    override func prepareForReuse() {
        backgroundImageView.image = nil
        posterImageView.image = nil
    }
}
