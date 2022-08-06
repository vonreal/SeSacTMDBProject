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
    var credit: ([Actor], [Crew]) = ([], [])
    
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
        
        let nibName2 = UINib(nibName: OverViewTableViewCell.reuseIdenfier, bundle: nil)
        castListTableView.register(nibName2, forCellReuseIdentifier: OverViewTableViewCell.reuseIdenfier)
    }
    
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return credit.0.count
        } else {
            return credit.1.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let overViewCell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.reuseIdenfier, for: indexPath) as? OverViewTableViewCell else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CastListTableViewCell.reuseIdenfier, for: indexPath) as? CastListTableViewCell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            overViewCell.overViewLabel.text = movie.overView
            overViewCell.overViewLabel.font = .systemFont(ofSize: 14)
            overViewCell.overViewLabel.textAlignment = .center
            
            overViewCell.moreButton.addTarget(self, action: #selector(moreButtonClicked), for: .touchUpInside)
            
            return overViewCell
        } else if indexPath.section == 1{
            let castList = credit.0
            
            cell.profileImageView.kf.setImage(with: castList[indexPath.row].width500ProfileURL)
            cell.profileImageView.layer.cornerRadius = 10
            cell.profileImageView.contentMode = .scaleAspectFill
            
            cell.nameLabel.text = castList[indexPath.row].name
            cell.nameLabel.font = .systemFont(ofSize: 14)
            
            cell.chracterNameLabel.text = castList[indexPath.row].getChracterName(movie: movie.title)
            cell.chracterNameLabel.font = .systemFont(ofSize: 12)
            cell.chracterNameLabel.textColor = .lightGray
            
            return cell
        } else {
            let crewList = credit.1
            
            cell.profileImageView.kf.setImage(with: crewList[indexPath.row].width500ProfileURL)
            cell.profileImageView.layer.cornerRadius = 10
            cell.profileImageView.contentMode = .scaleAspectFill
            
            cell.nameLabel.text = crewList[indexPath.row].name
            cell.nameLabel.font = .systemFont(ofSize: 14)
            
            cell.chracterNameLabel.text = crewList[indexPath.row].department
            cell.chracterNameLabel.font = .systemFont(ofSize: 12)
            cell.chracterNameLabel.textColor = .lightGray
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "OverView"
        } else if section == 1{
            return "Cast"
        } else {
            return "Crew"
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension MovieDetailViewController: OverViewCellDelegate {
    @objc func moreButtonClicked() {
        castListTableView.reloadData()
    }
}
