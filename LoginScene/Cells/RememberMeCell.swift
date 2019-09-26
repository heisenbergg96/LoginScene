//
//  RememberMeCell.swift
//  LoginScene
//
//  Created by Vikhyath on 02/08/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import UIKit

protocol RowViewModel {
    
    func rowHeight(viewHeight: CGRect?) -> CGSize
    var cellIdentifier: String { get }
}

protocol CellConfigurable {
    
    func setup(viewModel: RowViewModel)
    
}

extension CellConfigurable {
    
}

class RememberMeCell: UICollectionViewCell, CellConfigurable {
    
    func setup(viewModel: RowViewModel) {
        
        
    }
    
    @IBAction func rememberMeTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func enableTouchIdTapped(_ sender: UIButton) {
        
    }
    
}
