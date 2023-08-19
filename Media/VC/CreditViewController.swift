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
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mainPosterImageView: UIImageView!
    
    var movieID: Int?
    var pickedMovie: Result?
    var movieTitle: String?
    var castList = Credit(crew: [], id: 0, cast: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overviewTableView.rowHeight = UITableView.automaticDimension
        connectTableView()
        designView()
        setImage()
        callCast()
//        overviewTableView.rowHeight = .
    }
    
    func designView() {
        overviewLabel.text = "OverView"
        overviewLabel.font = .boldSystemFont(ofSize: 14)
        overviewLabel.textColor = .darkGray
        
        mainPosterImageView.layer.shadowOffset = .zero
        mainPosterImageView.layer.shadowColor = UIColor.black.cgColor
        mainPosterImageView.layer.shadowOpacity = 0.5
        
        castLabel.text = "Cast"
        castLabel.font = .boldSystemFont(ofSize: 14)
        castLabel.textColor = .darkGray
        
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white
        if let movieTitle {
            titleLabel.text = movieTitle
        }
        
        title = "출연/제작"
    }
    func connectTableView() {
        castTableView.dataSource = self
        castTableView.delegate = self
        overviewTableView.dataSource = self
        overviewTableView.delegate = self
    }
    func callCast() {
        guard let id = movieID else { return }
        let header: HTTPHeaders = ["Authorization": "Bearer \(APIKey.tmdb)"]
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits"
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseDecodable(of: Credit.self) { response in
            guard let value = response.value else { return }
            self.castList = value
            self.castTableView.reloadData()
        }
    }
    func setImage() {
        guard let movie = pickedMovie else { return }
        guard let url1 = URL(string: ImagePath.path + movie.backdropPath) else { return }
        guard let url2 = URL(string: ImagePath.path + movie.posterPath) else { return }
        DispatchQueue.global().async {
            let data1 = try! Data(contentsOf: url1)
            let data2 = try! Data(contentsOf: url2)
            DispatchQueue.main.async {
                self.posterImage.image = UIImage(data: data1)
                self.mainPosterImageView.image = UIImage(data: data2)
            }
        }
        
        
    }
}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case overviewTableView:
            return 1
        case castTableView:
            return castList.cast.count
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = pickedMovie else { return UITableViewCell() }
        
        switch tableView {
        case overviewTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else { return UITableViewCell()}
            cell.contentsLabel.text = movie.overview
            cell.contentsLabel.numberOfLines = 0

            return cell
            
        case castTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell() }
            
            let row = castList.cast[indexPath.row]
            
            cell.nameLabel.text = row.name
            cell.characterLabel.text = row.character
            
            guard let url = URL(string: ImagePath.path + (row.profilePath ?? "")) else {
                cell.profileImageView.backgroundColor = .systemGray4
                return cell
            }
            DispatchQueue.global().async {
                let data = try! Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.profileImageView.image = UIImage(data: data)
                }
            }
            return cell
        default: return UITableViewCell()
        }
//        if tableView == overviewTableView {
//            print("실행 되나? 오버뷰테이블뷰")
//            overviewCell.contentsLabel.text = "xx"//movie.overview
//            overviewCell.contentsLabel.numberOfLines = 0
//            return overviewCell
//        } else if tableView == castTableView {
//            castCell.nameLabel.text = "테스트"
//            return castCell
//        } else {
//            return UITableViewCell()
//        }
       
    }
    
    
}
