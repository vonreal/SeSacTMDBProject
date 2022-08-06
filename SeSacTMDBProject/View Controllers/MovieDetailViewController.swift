//
//  MovieDetailViewController.swift
//  SeSacTMDBProject
//
//  Created by 나지운 on 2022/08/05.
//

import UIKit

import Kingfisher

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var castListTableView: UITableView!
    
    var movie = Movie()
    var credit: [Actor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designUI()
        tableViewDelegate()
        registerNib()
    }
    
    func designUI() {
        let tintView = UIView()
        tintView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        tintView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: backdropImageView.frame.height)

        backdropImageView.addSubview(tintView)
        backdropImageView.contentMode = .scaleAspectFill
        
        backdropImageView.kf.setImage(with: movie.width500BackDropURL)
        
        posterImageView.kf.setImage(with: movie.width500PosterURL)
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 5
        
        movieTitleLabel.text = movie.title
        movieTitleLabel.font = .boldSystemFont(ofSize: 22)
        movieTitleLabel.adjustsFontSizeToFitWidth = true
        movieTitleLabel.textColor = .white
    }
    func tableViewDelegate() {
        castListTableView.delegate = self
        castListTableView.dataSource = self
    }
    func registerNib() {
        let nibName = UINib(nibName: CastListTableViewCell.reuseIdenfier, bundle: nil)
        castListTableView.register(nibName, forCellReuseIdentifier: CastListTableViewCell.reuseIdenfier)
    }
    
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CastListTableViewCell.reuseIdenfier) as? CastListTableViewCell else { return UITableViewCell() }
        
        if credit[indexPath.row].profilePath.isEmpty {
            cell.profileImageView.kf.setImage(with: URL(string: "https://us.123rf.com/450wm/nexusby/nexusby1805/nexusby180500076/100911331-%EA%B8%B0%EB%B3%B8-%EC%95%84%EB%B0%94%ED%83%80-%EC%82%AC%EC%A7%84-%EC%9E%90%EB%A6%AC-%ED%91%9C%EC%8B%9C-%EC%9E%90-%ED%94%84%EB%A1%9C%ED%95%84-%EC%82%AC%EC%A7%84.jpg?ver=6"))
        } else {
            cell.profileImageView.kf.setImage(with: credit[indexPath.row].width500ProfileURL)
        }
        cell.profileImageView.layer.cornerRadius = 10
        cell.profileImageView.contentMode = .scaleAspectFill
        
        cell.nameLabel.text = credit[indexPath.row].name
        cell.nameLabel.font = .systemFont(ofSize: 14)
        
        cell.chracterNameLabel.text = credit[indexPath.row].getChracterName(movie: movie.title)
        cell.chracterNameLabel.font = .systemFont(ofSize: 12)
        cell.chracterNameLabel.textColor = .lightGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cast"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
