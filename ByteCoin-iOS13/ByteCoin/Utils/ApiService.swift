//
//  ApiService.swift
//  ByteCoin
//
//  Created by nicho@mac on 25/01/25.
//  Copyright © 2025 The App Brewery. All rights reserved.
//

import Foundation

protocol ApiServiceDelegate {
    associatedtype ResponseType: Decodable
    
    func onLoading(_ isLoading: Bool)
    func onSuccess(_ response: ResponseType)
    func onError(_ error: ApiService.ErrorData)
}

struct ApiService {
    enum ErrorData: Error {
        case invalidURL
        case decodingError
        case networkError(String)
        case httpError(Int, String)
        case emptyData
        
        var errorMessage: String {
            switch self {
            case .invalidURL: return "Invalid URL provided"
            case .decodingError: return "Decoding failed from JSON"
            case .networkError(let details): return "Network error: \(details)"
            case .httpError(let statusCode, let serverMessage):
                guard let data = serverMessage.data(using: .utf8),
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let message = json["message"] as? String else {
                    return "HTTP error: Status code \(statusCode), message : \(serverMessage)"
                }
                return message
            case .emptyData: return "No data received from server"
            }
        }
    }
    
    
    func performRequest<Delegate: ApiServiceDelegate>(
        with url: URL,
        using delegate: Delegate
    ) {
        Task {
            delegate.onLoading(true)
            
            do {
                print("Fetching data from \(url)")
                
                let (data, response) = try await URLSession.shared.data(from: url)
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw ErrorData.invalidURL
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    let serverErrorMessage = String(data: data, encoding: .utf8) ?? "Unknown server error"
                    throw ErrorData.httpError(httpResponse.statusCode, serverErrorMessage)
                }
                
                guard let decodedData: Delegate.ResponseType = data.decode(as: Delegate.ResponseType.self) else {
                    throw ErrorData.decodingError
                }
                
                DispatchQueue.main.async {
                    delegate.onLoading(false)
                    
                    delegate.onSuccess(decodedData)
                }
            } catch let error as ErrorData {
                DispatchQueue.main.async {
                    delegate.onLoading(false)
                    
                    delegate.onError(error)
                }
            } catch {
                DispatchQueue.main.async {
                    delegate.onLoading(false)
                    
                    delegate.onError(.networkError(error.localizedDescription))
                }
            } 
        }
    }
}
