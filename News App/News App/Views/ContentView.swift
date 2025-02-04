//
//  ContentView.swift
//  News App
//
//  Created by nicho@mac on 01/02/25.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(networkManager.posts, rowContent: {
                post in
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(post.points ?? 0)")
                        Text(post.title ?? "").font(.headline)
                    }
                    Text(post.url ?? "")
                }
                
            }).navigationTitle("News App")
        }.onAppear() {
            Task {
                await networkManager.fetchData()
            }
        }
        
        Button("Fetch", action: {
            Task {
                await networkManager.fetchData()
            }
        })
    }
}

#Preview {
    ContentView()
}

