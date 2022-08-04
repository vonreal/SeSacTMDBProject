//
//  Movie.swift
//  SeSacTMDBProject
//
//  Created by 나지운 on 2022/08/04.
//

import Foundation

import Alamofire
import SwiftyJSON

struct Movie {
    static var genreList: [Int: String] = [:]
    
    init() {
        self.title = ""
        self.releaseDate = ""
        self.posterPath = ""
        self.backdropPath = ""
        self.voteAverage = 0.0
        self.overView = ""
        self.genreID = []
        self.movieID = 0
    }
    
    var title: String
    var releaseDate: String
    var backdropPath: String
    var posterPath: String
    var voteAverage: Double
    var overView: String
    var genreID: [Int]
    var movieID: Int
    
    var genres: [String] {
        var genres: [String] = []
        
        for genre in self.genreID {
            if let genreName = Movie.genreList[genre] {
                genres.append(genreName)
            }
        }
        
        return genres
    }
    
    var width500PosterURL: URL? {
        return URL(string: EndPoint.tmdbWidth500PosterURL + posterPath)
    }
    
    var originalPosterURL: URL? {
        return URL(string: EndPoint.tmdbOrignalPosterURL + posterPath)
    }
    
    var width500BackDropURL: URL? {
        return URL(string: EndPoint.tmdbWidth500PosterURL + backdropPath)
    }
    
    var originalBackDropURL: URL? {
        return URL(string: EndPoint.tmdbOrignalPosterURL + backdropPath)
    }
    
    static func setGenreList() {
        let url = EndPoint.tmdbGenreURL + APIKey.tmdbKey
        
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let value):
                    let genresList = JSON(value)["genres"].arrayValue
                    
                    for genre in genresList {
                        let id = genre["id"].intValue
                        let name = genre["name"].stringValue
                        
                        self.genreList[id] = name
                    }
                    break
                    
                case .failure(let error):
                    print(error)
                    break
                }
            }
    }
    
    
}
