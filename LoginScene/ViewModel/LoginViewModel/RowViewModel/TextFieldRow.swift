//
//  TextFieldRow.swift
//  LoginScene
//
//  Created by Vikhyath on 09/08/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import UIKit

class TextFieldRow: Row, RowViewModel {
    
    var isForgotPasswordVisible: Bool
    var placeholderText: String
    var isSecuretextEntry: Bool
    
    init(isForgotPasswordVisible: Bool, placeholderText: String, size: CGFloat, type: RowType, isSecureTextEntry: Bool) {
        
        self.isForgotPasswordVisible = isForgotPasswordVisible
        self.placeholderText = placeholderText
        self.isSecuretextEntry = isSecureTextEntry
        super.init(ratio: size, type: type)
    }
    
    
    func rowHeight(viewHeight: CGRect?) -> CGSize {
        
        guard let viewHeight = viewHeight else { return .zero}
        return CGSize(width: viewHeight.width, height: ratio * viewHeight.height)
    }
    
    var cellIdentifier: String = {
       
        TextFieldCell.reuseIdentifier
    }()
}
