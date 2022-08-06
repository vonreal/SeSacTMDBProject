//
//  PreviewVideoViewController.swift
//  SeSacTMDBProject
//
//  Created by 나지운 on 2022/08/07.
//

import UIKit
import WebKit

class PreviewVideoViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TrendMovieListAPIManager.shared.requestPreviewVideo(movieID: movie.movieID) { key in
            let youtubeURL = EndPoint.youtubeURL + key
            DispatchQueue.main.async {
                self.openWebPage(to: youtubeURL)
            }
        }
        
    }
    func openWebPage(to url: String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
