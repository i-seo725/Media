//
//  ViewController.swift
//  Media
//
//  Created by 이은서 on 2023/08/12.
//

import UIKit
import Alamofire
import SwiftyJSON


class TrendViewController: UIViewController {
    var list: [Movie] = []
    var code = [28: "Action", 12: "Adventure", 16: "Animation", 35: "Comedy", 80: "Crime", 99: "Documentary", 18: "Drama", 10751: "Family", 14: "Fantasy", 36: "History", 27: "Horror", 10402: "Music", 9648: "Mystery", 10749: "Romance", 878: "Science Fiction", 10770: "TV Movie", 53: "Thriller", 10752: "War", 37: "Western"]
    @IBOutlet var movieCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        callRequest()
        layout()
    }

    func layout() {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 20
        layout.itemSize = .init(width: width, height: width + 30)
        layout.minimumLineSpacing = 18
        layout.minimumInteritemSpacing = 18
        
        movieCollectionView.collectionViewLayout = layout
    }
    
    func callRequest() {
        let url = "https://api.themoviedb.org/3/trending/movie/day?language=ko-KR"
        let header: HTTPHeaders = ["Authorization": "Bearer \(APIKey.tmdb)"]
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                for i in json["results"].arrayValue {
                    let id = i["id"].intValue
                    let title = i["title"].stringValue
                    let release = i["release_date"].stringValue
                    let overview = i["overview"].stringValue
                    let posterImage = Movie.imagePath + i["poster_path"].stringValue
                    let backdropImage = Movie.imagePath + i["backdrop_path"].stringValue
                    let rate = i["vote_average"].doubleValue
                    let data = Movie(id: id, title: title, release: release, overview: overview, posterImage: posterImage, backdropImage: backdropImage, rate: rate)
                    self.list.append(data)
                }
                self.movieCollectionView.reloadData()
                
                
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension TrendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionViewCell.identifier, for: indexPath) as? TrendCollectionViewCell else {
            return UICollectionViewCell() }
        
        let row = list[indexPath.row]
        cell.titleLabel.text = row.title
        cell.dateLabel.text = row.release
        cell.genreLabel.text = "#\(row.genre)"
        cell.scoreLabel.text = "\(row.rate)"
        cell.castLabel.text = "테스트테스트테스트"
        
        let url = URL(string: "\(row.backdropImage)")!
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            
            DispatchQueue.main.async {
                cell.posterImage.image = UIImage(data: data)
                cell.loadingView.isHidden = true
                cell.loadingView.stopAnimating()
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "CreditViewController") as? CreditViewController else { return }
        vc.movieID = list[indexPath.row].id
        vc.pickedMovie = list[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
