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
    var pickedMovie: Movie?
    var movieTitle: String?
    var castList: [Cast] = []
    var isExpand: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overviewTableView.rowHeight = 300
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
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...600).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                for i in json["cast"].arrayValue {
                    let name = i["name"].stringValue
                    let character = i["character"].stringValue
                    let image = i["profile_path"].stringValue
                    self.castList.append(Cast(name: name, charactor: character, image: Cast.imageURL+image))
                    self.castTableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    func setImage() {
        guard let movie = pickedMovie else { return }
        guard let url1 = URL(string: movie.backdropImage) else { return }
        guard let url2 = URL(string: movie.posterImage) else { return }
        DispatchQueue.global().async {
            let data1 = try! Data(contentsOf: url1)
            let data2 = try! Data(contentsOf: url2)
            DispatchQueue.main.async {
                self.posterImage.image = UIImage(data: data1)
                self.mainPosterImageView.image = UIImage(data: data2)
            }
        }
        
        
    }
    
    @objc func expandButtonTapped(content: UILabel, icon: UIButton ) {
        if isExpand == false {
            content.numberOfLines = 0
            icon.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            overviewTableView.rowHeight = UITableView.automaticDimension
            isExpand.toggle()
        } else {
            content.numberOfLines = 4
            icon.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            isExpand.toggle()
        }
    }
}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case overviewTableView:
            return 1
        case castTableView:
            return castList.count
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = pickedMovie else { return UITableViewCell() }
        
        switch tableView {
        case overviewTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else { return UITableViewCell()}
            cell.contentsLabel.text = movie.overview
            cell.expandButton.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
            return cell
            
        case castTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell() }
            
            cell.nameLabel.text = castList[indexPath.row].name
            cell.characterLabel.text = castList[indexPath.row].charactor
            
            guard let url = URL(string: Cast.imageURL+castList[indexPath.row].image) else {
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
