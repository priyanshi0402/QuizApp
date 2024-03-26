//
//  UICollectionView+Kit.swift
//  QuizApp
//
//  Created by Priyanshi Bhikadiya on 2024-03-24.
//  Copyright © 2024 Priyanshi. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

    func registerCell<T: UICollectionViewCell>(ofType type: T.Type) {
        let cellName = String(describing: T.self)
        
        if Bundle.main.path(forResource: cellName, ofType: "nib") != nil {
            let nib = UINib(nibName: cellName, bundle: Bundle.main)
            register(nib, forCellWithReuseIdentifier: cellName)
        } else {
            register(T.self, forCellWithReuseIdentifier: cellName)
        }
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    
    func dequeueCell<T: UICollectionViewCell>(ofType type: T.Type, forIndexPath indexPath: IndexPath) -> T? {
        let cellName = String(describing: T.self)
        let cell = dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as? T
        return cell
    }
    
    func setBottomScrollInset() {
        self.contentInsetAdjustmentBehavior = .never
        self.contentInset.bottom = 20
    }
    
}
