//
//  ReusableViewProtocol.swift
//  SeSacTMDBProject
//
//  Created by 나지운 on 2022/08/04.
//

import UIKit

protocol ReusableViewProtocol {
    static var reuseIdenfier: String { get }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var reuseIdenfier: String {
        return String(describing: self)
    }
}
