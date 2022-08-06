//
//  ViewController.swift
//  SeSacTMDBProject
//
//  Created by 나지운 on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class TrendMovieListViewController: UIViewController {
    
    @IBOutlet weak var trendListCollectionView: UICollectionView!
    var weekTrendMovieList: [Movie] = []
    var credits: [Int: ([Actor], [Crew])] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Movie.setGenreList()
        requestTrendMovieListFromTMDB()
        
        collectionViewSetDelegate()
        registerNib()
        designCollectionView()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listButtonClicked))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonClicked))
        
        navigationController?.navigationBar.scrollEdgeAppearance = UINavigationBarAppearance()

    }
    
    @objc func listButtonClicked() { }
    @objc func searchButtonClicked() { }
    
    func collectionViewSetDelegate() {
        trendListCollectionView.delegate = self
        trendListCollectionView.dataSource = self
        trendListCollectionView.prefetchDataSource = self
    }
    func registerNib() {
        let nibName = UINib(nibName: TrendMovieListCollectionViewCell.reuseIdenfier, bundle: nil)
        trendListCollectionView.register(nibName, forCellWithReuseIdentifier: TrendMovieListCollectionViewCell.reuseIdenfier)
    }
    func requestTrendMovieListFromTMDB() {
        
        let url = EndPoint.tmdbURL + APIKey.tmdbKey
        
        AF.request(url, method: .get)
            .validate()
            .responseData(queue: .global()) { response in
                switch response.result {
                case .success(let value):
                    let jsonArray = JSON(value)["results"].arrayValue
                    
                    var index = 0
                    for json in jsonArray {
                        var movie = Movie()
                        movie.title = json["title"].stringValue
                        movie.movieID = json["id"].intValue
                        TrendMovieListAPIManager.shared.requestCredits(movieInfo: movie, index: index) { actors, crews, index in
                            self.credits[index] = (actors, crews)
                            DispatchQueue.main.sync {
                                self.trendListCollectionView.reloadData()
                            }
                        }
                        movie.overView = json["overview"].stringValue
                        movie.posterPath = json["poster_path"].stringValue
                        movie.backdropPath = json["backdrop_path"].stringValue
                        movie.genreID = json["genre_ids"].arrayValue.map { $0.intValue }
                        movie.voteAverage = json["vote_average"].doubleValue
                        movie.releaseDate = json["release_date"].stringValue
                        self.weekTrendMovieList.append(movie)
                        index += 1
                    }
                    DispatchQueue.main.sync {
                        self.trendListCollectionView.reloadData()
                    }
                    break

                case .failure(let error):
                    print(error)
                    break
                }
            }
    }
}

extension TrendMovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekTrendMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendMovieListCollectionViewCell.reuseIdenfier, for: indexPath) as? TrendMovieListCollectionViewCell else { return UICollectionViewCell() }
        
        let weekTrendMovie = weekTrendMovieList[indexPath.item]
        
        cell.releaseDateLabel.text = weekTrendMovie.releaseDate
        cell.releaseDateLabel.font = .systemFont(ofSize: 12)
        cell.releaseDateLabel.textColor = .lightGray
        
        
        if !credits.isEmpty {
            if let actors = credits[indexPath.item]?.0 {
                var castes = actors[0].name
                
                for actor in 1..<actors.count {
                    castes += ", \(actors[actor].name)"
                }
                cell.castsLabel.text = castes
            }
        }
        
        if !weekTrendMovie.genres.isEmpty {
            cell.genreLabel.text = "#\(weekTrendMovie.genres.randomElement()!)"
        }
        
        cell.genreLabel.font = .boldSystemFont(ofSize: 18)
        
        cell.posterImageView.kf.setImage(with: weekTrendMovie.width500BackDropURL!)
        cell.posterImageView.contentMode = .scaleAspectFill
        cell.posterImageView.layer.cornerRadius = 10
        cell.posterImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        cell.rateNameLabel.text = " 평점 "
        cell.rateNameLabel.backgroundColor = .purple
        cell.rateNameLabel.textColor = .white
        cell.rateNameLabel.textAlignment = .center
        cell.rateNameLabel.font = .systemFont(ofSize: 12)
        
        cell.rateLabel.text = String(format: " %.1f ", weekTrendMovie.voteAverage)
        cell.rateLabel.backgroundColor = .white
        cell.rateLabel.textColor = .black
        cell.rateLabel.textAlignment = .center
        cell.rateLabel.font = .systemFont(ofSize: 12)
        
        cell.titleLabel.text = weekTrendMovie.title
        cell.titleLabel.font = .boldSystemFont(ofSize: 18)
        cell.titleLabel.textColor = .darkGray
        
        cell.castsLabel.textColor = .lightGray
        cell.castsLabel.font = .systemFont(ofSize: 14)
        
        cell.lineView.layer.borderWidth = 0.5
        cell.lineView.layer.borderColor = UIColor.gray.cgColor
        
        cell.detailLabel.text = "자세히 보기"
        cell.detailLabel.font = .systemFont(ofSize: 12)
        
        cell.moreButton.setTitle("", for: .normal)
        cell.moreButton.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        
        cell.linkButton.layer.cornerRadius = 10
        
        cell.trendMovieVIew.layer.borderWidth = 0.1
        cell.trendMovieVIew.layer.borderColor = UIColor.lightGray.cgColor
        cell.trendMovieVIew.layer.shadowColor = UIColor.black.cgColor
        cell.trendMovieVIew.layer.shadowOpacity = 0.25
        cell.trendMovieVIew.layer.shadowRadius = 10
        
        cell.trendMovieVIew.layer.cornerRadius = 10
        cell.trendMovieVIew.layer.masksToBounds = false
        
        return cell
    }
    
    func designCollectionView() {
        trendListCollectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 40
        let itemSize = trendListCollectionView.frame.width - (trendListCollectionView.contentInset.left + trendListCollectionView.contentInset.right)
        
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = spacing
        
        trendListCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "TrendMovieList", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: MovieDetailViewController.reuseIdenfier) as? MovieDetailViewController else { return }
        
        vc.movie = weekTrendMovieList[indexPath.item]
        if let credit = credits[indexPath.item] {
            vc.credit = credit
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TrendMovieListViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.item == weekTrendMovieList.count - 1 {
                requestTrendMovieListFromTMDB()
            }
        }
    }
}
