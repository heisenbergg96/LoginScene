//
//  LoginVCViewModel.swift
//  LoginScene
//
//  Created by Vikhyath on 05/08/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import Foundation
import UIKit

class LoginViewModel {
    
    var sections: [Section] = []
    let numberOfSection = 3
    
    init() {
        for i in 0...numberOfSection-1 {
            guard let section = LoginSection(rawValue: i) else { return }
            sections.append(Section(type: section))
        }
    }
    
    func row(for indexPath: IndexPath) -> RowViewModel {
        
        return sections[indexPath.section].rows[indexPath.row]
    }
    
    func heightOfRow(at indexPath: IndexPath, viewHeight: CGRect?) -> CGSize {
        
        return sections[indexPath.section].rows[indexPath.row].rowHeight(viewHeight: viewHeight)
    }
    
    func referencesizeforHeader(in section: Int) -> CGSize {
        
        return sections[section].type.spacing
    }
    
    func reuseIdentifier(for indexPath: IndexPath) -> String {
        
        let identifier = row(for: indexPath).cellIdentifier
        
        return identifier
    }
}




