//
//  SecondViewController.swift
//  Media
//
//  Created by 이은서 on 2023/08/25.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {

    let label = {
        let view = IntroLabel()
        view.text = "트렌드 무비를 선택하여 상세 정보를 확인할 수 있습니다\n상세 화면 하단에서 추천 영화도 확인해보세요"
        return view
    }()
    let button = {
        let view = UIButton()
        view.setTitle("시작하기", for: .normal)
        view.setTitleColor(UIColor.systemBrown, for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 14)
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = 1.5
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.greaterThanOrEqualTo(view.safeAreaLayoutGuide).inset(20)
        }

        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view.safeAreaLayoutGuide).multipliedBy(1.5)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func startButtonTapped() {
        UserDefaults.standard.set(true, forKey: "isStarted")
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "TrendViewController") as? TrendViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }

}
