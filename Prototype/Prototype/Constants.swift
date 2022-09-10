//
//  Constants.swift
//  Prototype
//
//  Created by Volodymyr Myroniuk on 09.09.2022.
//

import Foundation

struct Constants {
    private init() {}
    
    struct Notifications {
        private init() {}
        
        struct Name {
            private init() {}
            
            static let toggleError = Notification.Name(rawValue: "RBWToggleError")
            static let gameStateDidChange = Notification.Name(rawValue: "RBWGameStateDidChange")
        }
        
        struct UserInfo {
            private init() {}
            
            struct Key {
                private init() {}
                
                static let showError: String = "RBWShowError"
                static let gameStateDidChange: String = "RBWGameStateDidChange"
            }
        }
    }
}
