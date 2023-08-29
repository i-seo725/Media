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
        view.tintColor = .lightGray
        return view
    }()
    let nameLabel = ProfileLabel()
    let idLabel = ProfileLabel()
    let introduceLabel = ProfileLabel()
    let linkLabel = ProfileLabel()
    let genderLabel = ProfileLabel()
    
    let nameButton = ProfileButton()
    let idButton = ProfileButton()
    let introduceButton = ProfileButton()
    let linkButton = ProfileButton()
    let genderButton = ProfileButton()
    
    
    override func configureView() {
        super.configureView()
        let views = [profileImageView, nameLabel, idLabel, introduceLabel, linkLabel, genderLabel, nameButton, idButton, introduceButton, linkButton, genderButton]
        
        for item in views {
            addSubview(item)
        }
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        }
        setText()
        
    }
    
    func setText() {
        nameLabel.text = "이름"
        idLabel.text = "사용자 이름"
        introduceLabel.text = "소개"
        linkLabel.text = "링크"
        genderLabel.text = "성별"
        
        nameButton.setTitle("이름", for: .normal)
        idButton.setTitle("사용자 이름", for: .normal)
        introduceButton.setTitle("소개", for: .normal)
        linkButton.setTitle("링크", for: .normal)
        genderButton.setTitle("성별", for: .normal)
    }
    
    override func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(12)
            make.width.equalToSuperview().multipliedBy(0.28)
            make.height.equalTo(50)
        }
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.size.equalTo(nameLabel)
        }
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom)
            make.leading.size.equalTo(nameLabel)
        }
        linkLabel.snp.makeConstraints { make in
            make.top.equalTo(introduceLabel.snp.bottom)
            make.leading.size.equalTo(nameLabel)
        }
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(linkLabel.snp.bottom)
            make.leading.size.equalTo(nameLabel)
        }
        
        nameButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel)
            make.leading.equalTo(nameLabel.snp.trailing)
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        idButton.snp.makeConstraints { make in
            make.top.equalTo(idLabel)
            make.leading.equalTo(idLabel.snp.trailing)
            make.trailing.height.equalTo(nameButton)
        }
        
        introduceButton.snp.makeConstraints { make in
            make.top.equalTo(introduceLabel)
            make.leading.equalTo(introduceLabel.snp.trailing)
            make.trailing.height.equalTo(nameButton)
        }
        
        linkButton.snp.makeConstraints { make in
            make.top.equalTo(linkLabel)
            make.leading.equalTo(linkLabel.snp.trailing)
            make.trailing.height.equalTo(nameButton)
        }
        
        genderButton.snp.makeConstraints { make in
            make.top.equalTo(genderLabel)
            make.leading.equalTo(genderLabel.snp.trailing)
            make.trailing.height.equalTo(nameButton)
        }
    }
}
