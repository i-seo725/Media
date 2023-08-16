//
//  DetailViewController.swift
//  Media
//
//  Created by 이은서 on 2023/08/12.
//

import UIKit
import Alamofire
import SwiftyJSON

class CreditViewController: UIViewController {

    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var castLabel: UILabel!
    @IBOutlet var castTableView: UITableView!
    @IBOutlet var overviewTableView: UITableView!
    
    var movieID: Int?
    var pickedMovie: Movie?
    var castList: [Cast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callCast()
        castTableView.dataSource = self
        castTableView.delegate = self
        overviewTableView.dataSource = self
        overviewTableView.delegate = self
        
        setPoster()
        overviewLabel.text = "OverView"
        overviewLabel.font = .boldSystemFont(ofSize: 14)
        overviewLabel.textColor = .darkGray
        
        castLabel.text = "Cast"
        castLabel.font = .boldSystemFont(ofSize: 14)
        castLabel.textColor = .darkGray
        
        title = "출연/제작"
    }
    func callCast() {
        guard let id = movieID else { return }
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    func setPoster() {
        guard let movie = pickedMovie else { return }
        guard let url = URL(string: movie.backdropImage) else { return }
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            DispatchQueue.main.async {
                self.posterImage.image = UIImage(data: data)
            }
        }
        
        
    }
}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == castTableView {
            return 1
        } else if tableView == overviewTableView {
            return 1
        } else {
            return 0
        }
//        switch tableView {
//        case castTableView: return 1
//        case overviewTableView: return 1
//        default: return 1
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let overviewCell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell") as? OverviewTableViewCell else { return UITableViewCell()}
        guard let castCell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell") as? CastTableViewCell else { return UITableViewCell() }
        guard let movie = pickedMovie else { return UITableViewCell() }
        
        if tableView == overviewTableView {
            overviewCell.contentsLabel.text = "xx"//movie.overview
            overviewCell.contentsLabel.numberOfLines = 0
            return overviewCell
        } else if tableView == castTableView {
            castCell.nameLabel.text = "테스트"
            return castCell
        } else {
            return UITableViewCell()
        }
        
//        switch tableView {
//        case overviewTableView:
//            overviewCell.contentsLabel.text = "xx"//movie.overview
//            overviewCell.contentsLabel.numberOfLines = 0
//            return overviewCell
//        case castTableView:
//            return castCell
//        default: return UITableViewCell()
//        }
    }
    
    
}
