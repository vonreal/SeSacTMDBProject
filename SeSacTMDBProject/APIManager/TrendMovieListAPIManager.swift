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
    
    typealias setCredits = ([Actor], [Crew], Int) -> ()

    func requestCredits(movieInfo: Movie, index: Int, setCredits: @escaping setCredits) {
        var actors: [Actor] = []
        var crews: [Crew] = []
        let url = EndPoint.tmdbMovieURL + String(movieInfo.movieID) + "/credits?api_key=" + APIKey.tmdbKey
        
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
                        actor.actorID = cast["id"].intValue

                        actors.append(actor)
                    }
                    
                    let crewList = JSON(value)["crew"].arrayValue
                    
                    for crew in crewList {
                        var person = Crew()
                        person.name = crew["name"].stringValue
                        person.profilePath = crew["profile_path"].stringValue
                        person.department = crew["department"].stringValue
                        person.crewID = crew["id"].intValue
                        
                        crews.append(person)
                    }
                    
                    setCredits(actors, crews, index)
                    break

                case .failure(let error):
                    print(error)
                    break
                }
            }
    }
    
    typealias setYoutubeLink = (String) -> ()
    
    func requestPreviewVideo(movieID: Int, setYoutubeLink: @escaping setYoutubeLink) {
        let url = EndPoint.tmdbMovieURL +  String(movieID) + "/videos?api_key=" + APIKey.tmdbKey
        
        AF.request(url, method: .get)
            .validate()
            .responseData(queue: .global()) { response in
                switch response.result {
                case .success(let value):
                    let keyList = JSON(value)["results"].arrayValue
                                                        .filter { $0["iso_639_1"].stringValue == "en" }
                                                        .filter { !$0["key"].stringValue.isEmpty }
                                                        .map {$0["key"].stringValue}
                    
                    setYoutubeLink(keyList[0])
                    break

                case .failure(let error):
                    print(error)
                    break
                }
            }
    }
}
