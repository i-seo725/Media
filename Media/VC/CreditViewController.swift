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

    static let identifier = "CreditViewController"
    
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var creditTableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mainPosterImageView: UIImageView!
    
//    var isExpand = false
    var movieID: Int?
    var pickedMovie: Result?
    var movieTitle: String?
    var castList = Credit(crew: [], id: 0, cast: [])
    var recommendedMovie = Movie(totalPages: 0, totalResults: 0, page: 0, results: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectTableView()
        designView()
        setImage()
        callCast()
        callRecommendation()
        creditTableView.rowHeight = UITableView.automaticDimension
    }
    
    func designView() {
        mainPosterImageView.layer.shadowOffset = .zero
        mainPosterImageView.layer.shadowColor = UIColor.black.cgColor
        mainPosterImageView.layer.shadowOpacity = 0.5
        
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white
        if let movieTitle {
            titleLabel.text = movieTitle
        }
        
        title = "출연/제작"
    }
    func connectTableView() {
        creditTableView.dataSource = self
        creditTableView.delegate = self
    }
    func callCast() {
        guard let id = movieID else { return }
        let header: HTTPHeaders = ["Authorization": "Bearer \(APIKey.tmdb)"]
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits"
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseDecodable(of: Credit.self) { response in
            guard let value = response.value else { return }
            self.castList = value
            self.creditTableView.reloadData()
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
    func callRecommendation() {
        print("@@@@@@@@@@@@   콜 요청 함수 실행")
        guard let id = movieID else { return }
        print("@@@@@@@@@@@@   아이디 받아오기 성공")
        let header: HTTPHeaders = ["Authorization": "Bearer \(APIKey.tmdb)"]
        let url = "https://api.themoviedb.org/3/movie/\(id)/recommendations"
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseDecodable(of: Movie.self) { response in
            guard let value = response.value else {
                print(url, response.error, response.value)
                return }
            self.recommendedMovie = value
            print("@@@@@@@@@@@@", self.recommendedMovie.results.count)
            self.creditTableView.reloadData()        }
    }
}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return castList.cast.count
        case 2:
            print(recommendedMovie.results.count)
            return recommendedMovie.results.count
        default: return 0
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Overview"
        case 1: return "Cast"
        case 2: return "Recommendation"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = pickedMovie else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else { return UITableViewCell()}
            cell.contentsLabel.text = movie.overview
            cell.selectionStyle = .none

            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell() }
            
            let row = castList.cast[indexPath.row]
            
            cell.nameLabel.text = row.name
            cell.characterLabel.text = row.character
            
            guard let url = URL(string: ImagePath.path + (row.profilePath ?? "")) else {
                cell.profileImageView.backgroundColor = .systemGray4
                return cell
            }
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: url) else {
                    DispatchQueue.main.async {
                        cell.profileImageView.backgroundColor = .systemGray4
                    }
                    return
                }
                DispatchQueue.main.async {
                    cell.profileImageView.image = UIImage(data: data)
                }
            }
            cell.selectionStyle = .none
            
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommendationTableViewCell.identifier) as? RecommendationTableViewCell else { return UITableViewCell() }
            let row = recommendedMovie.results[indexPath.row]
            cell.titleLabel.text = row.title
            cell.releaseLabel.text = row.releaseDate
            
            guard let backdropURL = URL(string: ImagePath.path + row.backdropPath), let posterURL = URL(string: ImagePath.path + row.posterPath) else {
                cell.backgroundImageView.backgroundColor = .systemGray4
                return cell
            }
            
            DispatchQueue.global().async {
                let backdropData = try! Data(contentsOf: backdropURL)
                let posterData = try! Data(contentsOf: posterURL)
                
                DispatchQueue.main.async {
                    cell.backgroundImageView.image = UIImage(data: backdropData)
                    cell.posterImageView.image = UIImage(data: posterData)
                }
            }
            return cell
            
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 100
        } else {
            return UITableView.automaticDimension
        }
    }
}
