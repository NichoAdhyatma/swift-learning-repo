//
//  NetworkManager.swift
//  News App
//
//  Created by nicho@mac on 01/02/25.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts: [Post] = [Post]()
    
    func fetchData() async  {
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            let sessionUrl = URLSession.shared
            
            do {
                let (data, _) = try await sessionUrl.data(for: URLRequest(url: url))
                
                let decoder = JSONDecoder()
                
                let newsData = try decoder.decode(Result.self, from: data)
                
                DispatchQueue.main.async {
                    self.posts = newsData.hits
                }
            } catch {
                
            }
            
        }
    }
}


