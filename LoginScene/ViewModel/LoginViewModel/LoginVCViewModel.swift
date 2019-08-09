//
//  LoginVCViewModel.swift
//  LoginScene
//
//  Created by Vikhyath on 05/08/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import Foundation
import UIKit

class Login {
    
    var sections: [Section] = []
    let numberOfSection = 3
    
    init() {
        for i in 0...numberOfSection-1 {
            guard let section = LoginSection(rawValue: i) else { return }
            sections.append(Section(type: section))
        }
    }
}

class LoginViewModel {
    
    var login: Login
    
    init(login: Login) {
        self.login = login
    }
}




