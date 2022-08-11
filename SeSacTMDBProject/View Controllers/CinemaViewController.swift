//
//  CinemaViewController.swift
//  SeSacTMDBProject
//
//  Created by 나지운 on 2022/08/11.
//

import UIKit
import MapKit

class CinemaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "detail", style: .plain, target: self, action: #selector(detailButtonClicked))
    }
    
    @objc func detailButtonClicked() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "메가박스", style: .default, handler: {_ in
        }))
        
        actionSheet.addAction(UIAlertAction(title: "롯데시네마", style: .default, handler: {_ in
        }))
        
        actionSheet.addAction(UIAlertAction(title: "CGV", style: .default, handler: {_ in
        }))
        
        actionSheet.addAction(UIAlertAction(title: "전체보기", style: .default, handler: {_ in
        }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true)
    }
                                                            
}
