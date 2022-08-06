//
//  OverViewTableViewCell.swift
//  SeSacTMDBProject
//
//  Created by 나지운 on 2022/08/06.
//

import UIKit

protocol OverViewCellDelegate: AnyObject {
    func moreButtonClicked()
}

class OverViewTableViewCell: UITableViewCell {
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!

    weak var delegate: OverViewCellDelegate?
    
    @IBAction func moreButtonClicked(_ sender: UIButton) {
        self.delegate?.moreButtonClicked()
        if self.moreButton.tag == 0 {
           self.moreButton.tag = 1
           self.moreButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)

           self.overViewLabel.numberOfLines = 0
        } else {
            self.moreButton.tag = 0
            self.moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)

            self.overViewLabel.numberOfLines = 2
        }
    }
}
