//
//  ThirdViewController.swift
//  SeSacTMDBProject
//
//  Created by 나지운 on 2022/08/18.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func startButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "first")
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate

        let sb = UIStoryboard(name: "TrendMovieList", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: TrendMovieListViewController.reuseIdenfier) as? TrendMovieListViewController else { print("Not found \(TrendMovieListViewController.reuseIdenfier)"); return }

        sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
