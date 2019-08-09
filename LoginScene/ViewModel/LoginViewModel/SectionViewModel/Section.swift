//
//  Section.swift
//  LoginScene
//
//  Created by Vikhyath on 09/08/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import UIKit

enum LoginSection: Int {
    
    case TextField, Remember, SignIn, count
    
    static var sectionCount = {
        return LoginSection.count.rawValue
    }()
    
    var numberOfRows: Int {
        return self == .TextField ? 3 : 1
    }
    
    var spacing: CGSize {
        
        let screenHeight = UIScreen.main.bounds.height
        let height: CGFloat = (self == .TextField) ? 0.23 : 0.05
        
        return CGSize(width: UIScreen.main.bounds.width, height: height * screenHeight)
    }
    
    fileprivate var heightOfRow: CGFloat {
        
        let height: CGFloat = (self == .SignIn) ? 126 : 0.09
        
        return height
    }
    
    var rowType: RowType {
        
        switch self {
        case .TextField:
            return .Field
        case .Remember:
            return .Checkbox
        default:
            return .Button
        }
    }
    
}

enum RowType: Int {
    
    case Field, Checkbox, Button
    
    func isSecureTextEntry(index: Int) -> Bool {
        
        return (self == .Field) && index == 2
    }
    
    func placeholderInTextField(index: Int) -> String {
        
        if self == .Field {
            
            switch index {
                
            case 0:
                return "Username"
            case 1:
                return "Company Id"
            default:
                return "Password"
            }
        }
        return ""
    }
}

class Section {
    
    var rows: [RowViewModel] = []
    var type: LoginSection
    
    init(type: LoginSection) {
        self.type = type
        createRows()
    }
    
    fileprivate func createRows() {
        
        for i in 0...type.numberOfRows - 1 {
            let rowType = type.rowType
            if type == .TextField {
                rows.append(TextFieldRow(isForgotPasswordVisible: false, placeholderText: rowType.placeholderInTextField(index: i), size: type.heightOfRow, type: rowType, isSecureTextEntry: rowType.isSecureTextEntry(index: i)))
            } else if rowType == .Checkbox {
                rows.append(RememberMeRow(size: type.heightOfRow, type: rowType, isEnabledTouchId: false, isEnabledRememberme: false))
            } else if rowType == .Button {
                rows.append(ButtonRow(ratio: type.heightOfRow, type: rowType))
            }
        }
    }
}


