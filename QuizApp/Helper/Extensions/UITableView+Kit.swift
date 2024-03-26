//
//  UITableView+Kit.swift
//  QuizApp
//
//  Created by Priyanshi Bhikadiya on 2024-03-24.
//  Copyright © 2024 Priyanshi. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(ofType type: T.Type) {
        let cellName = String(describing: T.self)
        
        if Bundle.main.path(forResource: cellName, ofType: "nib") != nil {
            let nib = UINib(nibName: cellName, bundle: Bundle.main)
            register(nib, forCellReuseIdentifier: cellName)
        } else {
            register(T.self, forCellReuseIdentifier: cellName)
        }
//        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    
    func dequeueCell<T: UITableViewCell>(ofType type: T.Type, forIndexPath indexPath: IndexPath) -> T? {
        let cellName = String(describing: T.self)
        let cell = dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? T
        cell?.selectionStyle = .none
        return cell
    }
   
    func setBottomScrollInset() {
        self.contentInsetAdjustmentBehavior = .never
        self.contentInset.bottom = 20
    }
    
    func hideRefreshControl() {
        self.refreshControl?.endRefreshing()
    }
    
}
