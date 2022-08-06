//
//  Crew.swift
//  SeSacTMDBProject
//
//  Created by 나지운 on 2022/08/06.
//

import Foundation

struct Crew {
    var crewID: Int = 0
    var name: String = ""
    var profilePath: String = ""
    var department: String = ""
    
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
