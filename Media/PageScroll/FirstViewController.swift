//
//  FirstViewController.swift
//  Media
//
//  Created by 이은서 on 2023/08/25.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {

    
    let label = {
        let view = IntroLabel()
        view.text = "안녕하세요 media 앱입니다 \n이 앱은 매일 그날의 트렌드 순위에 오른 영화를 보여줍니다"
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.greaterThanOrEqualTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
