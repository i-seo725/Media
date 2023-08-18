//
//  TrendCollectionViewCell.swift
//  Media
//
//  Created by 이은서 on 2023/08/13.
//

import UIKit

class TrendCollectionViewCell: UICollectionViewCell {
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var backView: UIView!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var lineView: UIView!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var loadingView: UIActivityIndicatorView!
    
    static let identifier = "TrendCollectionViewCell"
    override func awakeFromNib() {
        dateLabel.font = .systemFont(ofSize: 11)
        dateLabel.textColor = .darkGray
        
        genreLabel.font = .boldSystemFont(ofSize: 15)
        
        backView.layer.cornerRadius = 10
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 0.9
        backView.layer.shadowOffset = .zero
        
        titleLabel.font = .systemFont(ofSize: 16)
        
        overviewLabel.font = .systemFont(ofSize: 14)
        overviewLabel.textColor = .darkGray
        overviewLabel.numberOfLines = 1
        
        lineView.backgroundColor = .black
        
        rateLabel.text = "평점"
        rateLabel.textAlignment = .center
        rateLabel.backgroundColor = .systemBlue
        rateLabel.textColor = .white
        rateLabel.font = .systemFont(ofSize: 12)
        
        scoreLabel.textAlignment = .center
        scoreLabel.font = .systemFont(ofSize: 12)
        scoreLabel.backgroundColor = .white
        
        iconImage.tintColor = .black
        
        posterImage.contentMode = .scaleAspectFill
        
        detailLabel.font = .systemFont(ofSize: 11)
        detailLabel.text = "자세히 보기"
        
        loadingView.isHidden = false
        loadingView.startAnimating()
    }
    
    
}
