//
//  ContentView.swift
//  News App
//
//  Created by nicho@mac on 01/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(posts, rowContent: {
                post in
                Text(post.title)
                    .font(.headline)
            }).navigationTitle("News App")
        }
    }
}

#Preview {
    ContentView()
}


struct Post: Identifiable {
    var id: UUID = UUID()
    var title: String
    var content: String
}


let posts: [Post] = [
    .init(title: "Post 1", content: "Content of Post 1"),
    .init(title: "Post 2", content: "Content of Post 2"),
    .init(title: "Post 3", content: "Content of Post 3")
]
