//
//  Row.swift
//  LoginScene
//
//  Created by Vikhyath on 09/08/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import UIKit

class Row {
    
    var ratio: CGFloat
    var type: RowType
    
    init(ratio: CGFloat, type: RowType) {
        self.ratio = ratio
        self.type = type
    }
}
