//
//  testViewController.swift
//  Media
//
//  Created by 이은서 on 2023/08/26.
//

import UIKit

class SimilarViewController: UIViewController {

    static let identifier = "SimilarViewController"
    var movieID: Int?
    var similarMovie: Movie?
    var video: Video?
    
    
    @IBOutlet var similarTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        similarTableView.delegate = self
        similarTableView.dataSource = self
        
        
        let group = DispatchGroup()
        
        group.enter()
        requestSimilar {
            print(#function)
            group.leave()
        }
        
        group.enter()
        requestVideo {
            print(#function)
            group.leave()
        }
        group.notify(queue: .main) {
            self.similarTableView.reloadData()
            self.similarTableView.rowHeight = UITableView.automaticDimension
        }
    }
   
    func requestSimilar(handler: @escaping () -> Void) {
        guard let movieID else { return }
        NetworkManager.shared.callRequest(codable: Movie(totalPages: 0, totalResults: 0, page: 0, results: []), type: .similar, id: movieID) { data in
            self.similarMovie = data
            handler()
        }
    }
    
    func requestVideo(handler: @escaping () -> Void) {
    
        guard let movieID = self.movieID else { return }
        NetworkManager.shared.callRequest(codable: Video(id: 0, results: []), type: .video, id: movieID) { data in
            self.video = data
            handler()
        }
        
        
    }
    


}


extension SimilarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SimilarTableViewCell.identifier) as? SimilarTableViewCell else { return UITableViewCell() }
        
        guard let similarMovie else { return UITableViewCell() }
        guard let video else { return UITableViewCell() }
        
        cell.titleLabel.text = similarMovie.results[indexPath.row].title
        cell.linkLabel.text = ImagePath.youtubePath + video.results[indexPath.row].key
        
        return cell
    }
    
    
}
