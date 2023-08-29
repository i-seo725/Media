//
//  ProfileView.swift
//  Media
//
//  Created by 이은서 on 2023/08/29.
//

import UIKit

class ProfileView: BaseView {
    
    let profileImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.circle")
        view.tintColor = .white
        return view
    }()
    
    
    override func configureView() {
        super.configureView()
        
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        }
        
    }
    
    override func setConstraints() {
        
    }
}
