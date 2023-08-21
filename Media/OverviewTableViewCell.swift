//
//  OverviewTableViewCell.swift
//  Media
//
//  Created by 이은서 on 2023/08/15.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    static let identifier = "OverviewTableViewCell"
    var isExpand = false
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var expandButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        expandButton.setTitle("", for: .normal)
        expandButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        expandButton.tintColor = .black
        
        contentsLabel.font = .systemFont(ofSize: 14)
        contentsLabel.numberOfLines = 0

//        expandButton.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
    }
    
//    @objc func expandButtonTapped() {
//        if isExpand == false {
//            contentsLabel.numberOfLines = 0
//            expandButton.setImage(UIImage(systemName: "chervon.up"), for: .normal)
//            isExpand.toggle()
//        } else {
//            contentsLabel.numberOfLines = 2
//            expandButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
//            isExpand.toggle()
//        }
//    }
}
