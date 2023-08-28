//
//  BaseCollectionViewCell.swift
//  Media
//
//  Created by 이은서 on 2023/08/28.
//

import UIKit
import SnapKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() { }
    func setConstraints() { }
    
    
}
