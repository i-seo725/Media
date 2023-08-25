//
//  IntroLabelClass.swift
//  Media
//
//  Created by 이은서 on 2023/08/25.
//

import UIKit

class IntroLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabel() {
        textColor = .systemMint
        font = .boldSystemFont(ofSize: 20)
        textAlignment = .center
        numberOfLines = 0
    }
}
