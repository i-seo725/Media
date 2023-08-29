//
//  EditView.swift
//  Media
//
//  Created by 이은서 on 2023/08/30.
//

import UIKit

class EditView: BaseView {
    
    let editedItemLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 11)
        view.textColor = .lightGray
        view.textAlignment = .left
        view.text = "임시 텍스트"
        return view
    }()
    
    let textField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    
    override func configureView() {
        super.configureView()
        addSubview(editedItemLabel)
        addSubview(textField)
    }
    
    override func setConstraints() {
        editedItemLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(4)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(12)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(editedItemLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(40)
        }
    }
}
