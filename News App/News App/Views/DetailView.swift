//
//  DetailView.swift
//  News App
//
//  Created by nicho@mac on 01/02/25.
//

import SwiftUI
import WebKit

struct DetailView: View {
    var url: String?
    
    var body: some View {
        WebView(url: url)
    }
}

#Preview {
    DetailView()
}

struct WebView: UIViewRepresentable {
    let url: String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeUrlString = url {
            if let urlObject = URL(string: safeUrlString) {
                let request = URLRequest(url: urlObject)
                
                uiView.load(request)
            }
           
        }
    }
    
    
}
