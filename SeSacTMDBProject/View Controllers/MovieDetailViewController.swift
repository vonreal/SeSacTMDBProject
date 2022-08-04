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
        tintView.frame = CGRect(x: 0, y: 0, width: backdropImageView.frame.width, height: backdropImageView.frame.height)

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
        
        cell.profileImageView.kf.setImage(with: credit[indexPath.row].width500ProfileURL)
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
}
