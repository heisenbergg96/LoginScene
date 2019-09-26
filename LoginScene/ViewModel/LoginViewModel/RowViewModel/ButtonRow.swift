//
//  ButtonRow.swift
//  LoginScene
//
//  Created by Vikhyath on 09/08/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import UIKit

class ButtonRow: Row, RowViewModel {
    
    var cellIdentifier: String = {
        
        return ButtonCell.reuseIdentifier
    }()
    
    var signInButtonTapped: (() -> Void)? = nil
    
    init(ratio: CGFloat, type: RowType, signInButtonTapped: (() -> Void)? = nil) {
        
        super.init(ratio: ratio, type: type)
        self.signInButtonTapped = signInButtonTapped
        
    }
    
    func rowHeight(viewHeight: CGRect?) -> CGSize {
        guard let viewHeight = viewHeight else { return .zero }
        return CGSize(width: viewHeight.width, height: ratio)
    }
    
    
}
