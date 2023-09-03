//
//  TVCollectionViewCell.swift
//  Media
//
//  Created by 이은서 on 2023/09/03.
//

import UIKit

class TVCollectionViewCell: BaseCollectionViewCell {
    
    var backdropImage = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    var titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 15)
        view.textAlignment = .center
        view.numberOfLines = 1
        return view
    }()
    
    var overviewLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textAlignment = .left
        view.numberOfLines = 2
        return view
    }()
    
    override func prepareForReuse() {
        backdropImage.image = nil
    }
    
    
    override func configureView() {
        contentView.backgroundColor = .white
        contentView.addSubview(backdropImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
    }
    
    override func setConstraints() {
        backdropImage.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(contentView.safeAreaLayoutGuide).inset(30)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backdropImage.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.horizontalEdges.greaterThanOrEqualTo(contentView.safeAreaLayoutGuide).inset(20)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
}
