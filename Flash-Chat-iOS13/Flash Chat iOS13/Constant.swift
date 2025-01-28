//
//  AppSegue.swift
//  Flash Chat iOS13
//
//  Created by nicho@mac on 28/01/25.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

struct Constant {
    static let appTitle = "⚡️FlashChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerToChat = "registerToChat"
    static let loginToChat = "loginToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}

