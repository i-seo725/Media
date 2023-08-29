//
//  ProfileViewController.swift
//  Media
//
//  Created by 이은서 on 2023/08/29.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(nameButtonNotificationObserver), name: NSNotification.Name("text"), object: nil)
    }
    
    override func configureView() {
        
        mainView.nameButton.addTarget(self, action: #selector(nameButtonTapped), for: .touchUpInside)
        mainView.idButton.addTarget(self, action: #selector(idButtonTapped), for: .touchUpInside)
        mainView.introduceButton.addTarget(self, action: #selector(introduceButtonTapped), for: .touchUpInside)
        mainView.linkButton.addTarget(self, action: #selector(nameButtonTapped), for: .touchUpInside)
        mainView.genderButton.addTarget(self, action: #selector(nameButtonTapped), for: .touchUpInside)
    }
    
    @objc func nameButtonTapped() {
        navigationController?.pushViewController(EditViewController(), animated: true)
    }
    
    @objc func nameButtonNotificationObserver(notificaton: NSNotification) {
        if let text = notificaton.userInfo?["value"] as? String {
            self.mainView.nameButton.setTitle(text, for: .normal)
            self.mainView.nameButton.setTitleColor(.black, for: .normal)
        }
    }
    
    @objc func idButtonTapped() {
        let vc = EditViewController()
        vc.deleagte = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func introduceButtonTapped() {
        let vc = EditViewController()
        vc.completionHandler = { text in
            self.mainView.introduceButton.setTitle(text, for: .normal)
            self.mainView.introduceButton.setTitleColor(.black, for: .normal)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController: PassDataDelegate {
    func receiveData(text: String) {
        mainView.idButton.setTitle(text, for: .normal)
        mainView.idButton.setTitleColor(.black, for: .normal)
    }
}
