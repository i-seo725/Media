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
        contentsLabel.numberOfLines = 2

        expandButton.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
    }
    
    @objc func expandButtonTapped() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(identifier: CreditViewController.identifier) as? CreditViewController else { return }
        
        
        if isExpand == false {
            contentsLabel.numberOfLines = 0
            expandButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            vc.creditTableView.reloadData()
            isExpand.toggle()
        } else {
            contentsLabel.numberOfLines = 2
            expandButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            vc.creditTableView.reloadData()
            isExpand.toggle()
        }
    }
}
