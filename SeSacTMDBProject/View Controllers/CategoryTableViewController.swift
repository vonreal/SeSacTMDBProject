//
//  CategoryTableViewController.swift
//  SeSacTMDBProject
//
//  Created by 나지운 on 2022/08/11.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseIdenfier, for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = "🍿 주변 영화관 위치"
        cell.titleLabel.font = .systemFont(ofSize: 16)
        cell.accessoryType = .disclosureIndicator
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let sb = UIStoryboard(name: "TrendMovieList", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: CinemaViewController.reuseIdenfier) as? CinemaViewController else { return }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
