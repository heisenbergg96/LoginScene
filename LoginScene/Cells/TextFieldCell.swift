//
//  TextFieldCell.swift
//  LoginScene
//
//  Created by Vikhyath on 02/08/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import UIKit

class TextFieldCell: UICollectionViewCell, CellConfigurable, UITextFieldDelegate {
    
    @IBOutlet weak var textField: FloatingTextField!
    @IBOutlet weak var dividerView: UIImageView!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    func setup(viewModel: RowViewModel) {
        
        guard let textfieldRow = viewModel as? TextFieldRow else {
            return
        }
        
        textField.placeholder = textfieldRow.placeholderText
        forgotPasswordButton.isHidden = !textfieldRow.isForgotPasswordVisible
        textField.isSecureTextEntry = textfieldRow.isSecuretextEntry
    }
    
    @IBAction func forgotPasswordButtonTapped(_ sender: UIButton) {
        
    }
    
    
}
