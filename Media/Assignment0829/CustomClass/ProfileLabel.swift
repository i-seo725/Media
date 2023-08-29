//
//  ProfileLabel.swift
//  Media
//
//  Created by 이은서 on 2023/08/29.
//

import UIKit

class ProfileLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDesign() {
        textColor = .black
        textAlignment = .left
        font = .systemFont(ofSize: 15)
        
    }
    
}
