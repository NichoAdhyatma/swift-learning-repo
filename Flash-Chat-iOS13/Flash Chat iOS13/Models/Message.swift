//
//  Message.swift
//  Flash Chat iOS13
//
//  Created by nicho@mac on 28/01/25.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

struct Message {
    var sender: String
    var body: String
    
    init(sender: String, body: String) {
        self.sender = sender
        self.body = body
    }
    
    static func fromSnapshot(_ data: [String: Any]) -> Message? {
        guard let sender = data[Constant.FStore.senderField] as? String,
              let body = data[Constant.FStore.bodyField] as? String else {
            return nil
        }
        return Message(sender: sender, body: body)
    }
}
