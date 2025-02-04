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
                NavigationLink(destination: DetailView(url: post.url)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\(post.points ?? 0)").font(.caption).fontWeight(.bold).lineLimit(2)
                        
                        Text(post.title ?? "").font(.headline)
                        
                        Text(post.url ?? "").font(.subheadline).foregroundColor(.blue).lineLimit(1).underline(true, color: .blue)
                    }
                }
               
                
            }).navigationTitle("News App")
        }.onAppear() {
            Task {
                await networkManager.fetchData()
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}

