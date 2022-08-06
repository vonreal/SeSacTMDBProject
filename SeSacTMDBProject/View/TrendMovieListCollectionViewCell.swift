//
//  TrendMovieListCollectionViewCell.swift
//  SeSacTMDBProject
//
//  Created by 나지운 on 2022/08/04.
//

import UIKit

protocol TrendMovieListCellDelegate: AnyObject {
    func linkButtonClicked(buttonTag: Int)
}

class TrendMovieListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var rateNameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var castsLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var trendMovieVIew: UIView!
    
    weak var delegate: TrendMovieListCellDelegate?
    
    @IBAction func linkButtonClicked(_ sender: UIButton) {
        self.delegate?.linkButtonClicked(buttonTag: sender.tag)
    }
}
