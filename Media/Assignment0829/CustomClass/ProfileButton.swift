//
//  ProfileButton.swift
//  Media
//
//  Created by 이은서 on 2023/08/29.
//

import UIKit

class ProfileButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setDesign() {
        setTitleColor(.lightGray, for: .normal)
//        tintColor = .black
        titleLabel?.font = .systemFont(ofSize: 15)
        contentHorizontalAlignment = .leading
    }
}
