//
//  VideoTableViewCell.swift
//  Media
//
//  Created by 이은서 on 2023/08/26.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    static let identifier = "VideoTableViewCell"
    
    @IBOutlet var videoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        videoLabel.text = "관련 동영상 보러 가기"
        videoLabel.font = .boldSystemFont(ofSize: 14)
        videoLabel.textAlignment = .center
    }


}
