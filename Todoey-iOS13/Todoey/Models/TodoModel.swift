//
//  TodoModel.swift
//  Todoey
//
//  Created by nicho@mac on 09/02/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

struct TodoModel: Codable {
    var title: String
    var done: Bool
    
    init(title: String = "", done: Bool = false) {
        self.title = title
        self.done = done
    }
}
