//
//  RememberMeRow.swift
//  LoginScene
//
//  Created by Vikhyath on 09/08/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import UIKit

class RememberMeRow: Row, RowViewModel {
    
    var isEnabledTouchId: Bool
    var isEnabledRememberme: Bool
    
    init(size: CGFloat, type: RowType, isEnabledTouchId: Bool, isEnabledRememberme: Bool) {
        
        self.isEnabledTouchId = isEnabledTouchId
        self.isEnabledRememberme = isEnabledRememberme
        super.init(ratio: size, type: type)
        
    }
    
    func rowHeight(viewHeight: CGRect?) -> CGSize {
        
        guard let viewHeight = viewHeight else { return .zero }
        return CGSize(width: viewHeight.width, height: ratio * viewHeight.height)
    }
    
}
