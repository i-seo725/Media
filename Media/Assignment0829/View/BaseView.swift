//
//  BaseView.swift
//  Media
//
//  Created by 이은서 on 2023/08/29.
//

import UIKit
import SnapKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        backgroundColor = .white
    }
    
    func setConstraints() { }
    
}
