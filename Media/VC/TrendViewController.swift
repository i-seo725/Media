//
//  ViewController.swift
//  Media
//
//  Created by 이은서 on 2023/08/12.
//

import UIKit
import Alamofire

class TrendViewController: UIViewController {
    var movieList: Movie?
    var TVList: TVShow?
//    lazy var movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    @IBOutlet var movieCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieCollectionView.delegate = self
        self.movieCollectionView.dataSource = self
        movieCollectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: "TVCollectionViewCell")
        movieCollectionView.collectionViewLayout = layout()
        title = "오늘의 트렌드"
        callMovieRequest()
        callTVRequest()
    }
    
    func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 20
        layout.itemSize = .init(width: width, height: width + 30)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10

        return layout
    }
    
    func callMovieRequest() {
        NetworkManager.shared.callRequest(codable: Movie(totalPages: 0, totalResults: 0, page: 0, results: []), type: .trend) { data in
            self.movieList = data
            self.movieCollectionView.reloadData()
        }
    }
    
    func callTVRequest() {
        NetworkManager.shared.callRequest(codable: TVShow(page: 0, results: [], totalPages: 0, totalResults: 0), type: .tv) { data in
            self.TVList = data
            self.movieCollectionView.reloadData()
        }
    }

}

extension TrendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let movieList, let TVList else { return 0 }
        return movieList.results.count + TVList.results.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieList, let TVList else { return UICollectionViewCell() }
        
        if indexPath.item < movieList.results.count {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionViewCell.identifier, for: indexPath) as? TrendCollectionViewCell else {
                return UICollectionViewCell() }
            
            let row = movieList.results[indexPath.row]
            cell.titleLabel.text = row.title
            cell.originalTitleLabel.text = row.originalTitle
            cell.dateLabel.text = row.releaseDate
            cell.genreLabel.text = "#\(Genre.findGenre(id: row.genreID[0]))"
            cell.scoreLabel.text = "\(row.voteAverage)"
            cell.overviewLabel.text = row.overview
            
            let url = URL(string: "\(ImagePath.path + row.backdropPath!)")!
            DispatchQueue.global().async {
                let data = try! Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.posterImage.image = UIImage(data: data)
                    cell.loadingView.isHidden = true
                    cell.loadingView.stopAnimating()
                }
            }
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVCollectionViewCell", for: indexPath) as? TVCollectionViewCell else { return UICollectionViewCell()}
            
            let row = TVList.results[indexPath.item - 20]
            cell.titleLabel.text = row.name
            cell.overviewLabel.text = row.overview
            
            if let backdropPath = row.backdropPath {
                guard let url = URL(string: "\(ImagePath.path + backdropPath)") else {
                    cell.backdropImage.backgroundColor = .gray
                    return UICollectionViewCell()
                }
                DispatchQueue.global().async {
                    let data = try! Data(contentsOf: url)
                    DispatchQueue.main.async {
                        cell.backdropImage.image = UIImage(data: data)
                    }
                }
            }
            
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieList, let TVList, let vc = storyboard?.instantiateViewController(identifier: "CreditViewController") as? CreditViewController else { return }
            if indexPath.item < movieList.results.count {
                let row = movieList.results[indexPath.row]// else { return }
                vc.movieID = row.id
                vc.pickedMovie = row
                vc.media = .movie
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let row = TVList.results[indexPath.item - 20]
                vc.tvID = row.id
                vc.pickedTV = row
                vc.media = .tv
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    
}
