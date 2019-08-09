//
//  ButtonCell.swift
//  LoginScene
//
//  Created by Vikhyath on 02/08/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import UIKit

class ButtonCell: UICollectionViewCell, CellConfigurable {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signInButtonStack: UIStackView!
    
    func setup(viewModel: RowViewModel) {
        
    }
    
}
