//
//  Actor.swift
//  SeSacTMDBProject
//
//  Created by 나지운 on 2022/08/04.
//

import Foundation

struct Actor {
    var actorID: Int = 0
    var name: String = ""
    var profilePath: String = ""
    private var movieChracterName: [String: String] = [:]
    mutating func setChracterName(movie: String, name: String) {
        self.movieChracterName[movie] = name
    }
    
    func getChracterName(movie: String) -> String? {
        return self.movieChracterName[movie]
    }
    
    var width500ProfileURL: URL? {
        if profilePath.isEmpty {
            return URL(string: EndPoint.noProfileImageURL)
        } else {
            return URL(string: EndPoint.tmdbWidth500PosterURL + profilePath)
        }
        
    }
    
    var originProfileURL: URL? {
        if profilePath.isEmpty {
            return URL(string: EndPoint.noProfileImageURL)
        } else {
            return URL(string: EndPoint.tmdbOrignalPosterURL + profilePath)
        }
    }
}
