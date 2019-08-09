//
//  UICollectionView.swift
//  LoginScene
//
//  Created by Vikhyath on 05/08/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import UIKit

protocol ReusableView {
    
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    
    static var reuseIdentifier: String {
        
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableView {
    
}

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError()
        }
        
        return cell
    }
}

