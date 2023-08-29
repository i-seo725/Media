//
//  ViewController.swift
//  Media
//
//  Created by 이은서 on 2023/08/12.
//

import UIKit
import Alamofire

class TrendViewController: UIViewController {
    var list: Movie?
//    lazy var movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    @IBOutlet var movieCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieCollectionView.delegate = self
        self.movieCollectionView.dataSource = self
        title = "오늘의 트렌드"
        callRequest()
    
        //스토리보드 기반으로 연결하기
//        movieCollectionView.register(TrendCollectionViewCell.self, forCellWithReuseIdentifier: "TrendCollectionViewCell")
        
//        movieCollectionView.register(UINib(nibName: TrendCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TrendCollectionViewCell.identifier)
      
        
    }

//    override func configureView() {
//        super.configureView()
//        view.addSubview(movieCollectionView)
//        movieCollectionView.addSubview(TrendCollectionViewCell())
//    }
    
//    override func setConstraints() {
//        movieCollectionView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
    
//    func layout() -> UICollectionViewFlowLayout {
//        let layout = UICollectionViewFlowLayout()
//        let width = UIScreen.main.bounds.width - 20
//        layout.itemSize = .init(width: width, height: width + 30)
//        layout.minimumLineSpacing = 18
//        layout.minimumInteritemSpacing = 18
//
//        return layout
//    }
    
    func callRequest() {
        NetworkManager.shared.callRequest(codable: Movie(totalPages: 0, totalResults: 0, page: 0, results: []), type: .trend) { data in
            self.list = data
            self.movieCollectionView.reloadData()
        }
        
    }

}

extension TrendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let list else { return 0 }
        return list.results.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionViewCell.identifier, for: indexPath) as? TrendCollectionViewCell else {
            return UICollectionViewCell() }
        
        guard let list else { return UICollectionViewCell() }
        
        let row = list.results[indexPath.row]
        print("@@@@@@@", cell)//.titleLabel)
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
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "CreditViewController") as? CreditViewController else { return }
        guard let list else { return }
        let row = list.results[indexPath.row]// else { return }
        vc.movieID = row.id
        vc.pickedMovie = row
        vc.movieTitle = row.title
        navigationController?.pushViewController(vc, animated: true)
    }
}
