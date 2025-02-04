//
//  Post.swift
//  News App
//
//  Created by nicho@mac on 01/02/25.
//

import Foundation

struct Result: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    let objectId: String?
    var id: String {
        return objectId ?? UUID().uuidString
    }
    let points: Int?
    let title: String?
    let url: String?
}
