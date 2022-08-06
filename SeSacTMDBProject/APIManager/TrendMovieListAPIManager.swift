//
//  TrendMovieListAPIManager.swift
//  SeSacTMDBProject
//
//  Created by 나지운 on 2022/08/05.
//

import Foundation

import Alamofire
import SwiftyJSON
import UIKit

class TrendMovieListAPIManager {
    private init() { }
    
    static let shared = TrendMovieListAPIManager()
    
    typealias setGenreList = (Int, String) -> ()
    
    func requestGenreList(setGenreList: @escaping setGenreList) {
        let url = EndPoint.tmdbGenreURL + APIKey.tmdbKey
        
        AF.request(url, method: .get)
            .validate()
            .responseData(queue: .global()) { response in
                switch response.result {
                case .success(let value):
                    let genresList = JSON(value)["genres"].arrayValue
                    
                    for genre in genresList {
                        let id = genre["id"].intValue
                        let name = genre["name"].stringValue
                        
                        setGenreList(id, name)
                    }
                    
                    break
                    
                case .failure(let error):
                    print(error)
                    break
                }
            }
    }
    
    typealias setCredits = ([Actor], Int) -> ()
    
    func requestCredits(movieInfo: Movie, index: Int, setCredits: @escaping setCredits) {
        let url = EndPoint.tmdbCreditsURL + String(movieInfo.movieID) + "/credits?api_key=" + APIKey.tmdbKey
        var actors: [Actor] = []
        AF.request(url, method: .get)
            .validate()
            .responseData(queue: .global()) { response in
                switch response.result {
                case .success(let value):
                    let castList = JSON(value)["cast"].arrayValue
                    
                    for cast in castList {
                        var actor = Actor()
                        actor.name = cast["name"].stringValue
                        actor.profilePath = cast["profile_path"].stringValue
                        actor.setChracterName(movie: movieInfo.title, name: cast["character"].stringValue)
                        actor.actorId = cast["id"].intValue

                        actors.append(actor)
                    }
                    
                    setCredits(actors, index)
                    break

                case .failure(let error):
                    print(error)
                    break
                }
            }
    }
}
