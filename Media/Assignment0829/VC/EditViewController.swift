//
//  EditViewController.swift
//  Media
//
//  Created by 이은서 on 2023/08/30.
//

import UIKit

protocol PassDataDelegate {
    func receiveData(text: String)
}

class EditViewController: BaseViewController {
    
    let mainView = EditView()
    override func loadView() {
        self.view = mainView
    }
    
    var deleagte: PassDataDelegate?
    var completionHandler: ((String) -> Void)?
    
    override func configureView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(doneButtonTapped))
    }
    
    @objc func doneButtonTapped() {
        guard let text = mainView.textField.text else { return }
        NotificationCenter.default.post(name: NSNotification.Name("text"), object: nil, userInfo: ["value": text])
        deleagte?.receiveData(text: text)
        completionHandler?(text)
        navigationController?.popViewController(animated: true)
    }
}
