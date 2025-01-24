//
//  ApiService.swift
//  Clima
//
//  Created by nicho@mac on 22/01/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

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
    
    
    func performRequest<T: Decodable>(
        with url: URL,
        as type: T.Type,
        onSuccess: @escaping (T) -> Void,
        onError: @escaping (ErrorData) -> Void
    ) {
        Task {
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw ErrorData.invalidURL
                }
                
                data.printPrettyJSON
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    let serverErrorMessage = String(data: data, encoding: .utf8) ?? "Unknown server error"
                    throw ErrorData.httpError(httpResponse.statusCode, serverErrorMessage)
                }
                
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                
                
                DispatchQueue.main.async {
                    onSuccess(decodedData)
                }
            } catch let error as ErrorData {
                
                DispatchQueue.main.async {
                    onError(error)
                }
            } catch {
                
                DispatchQueue.main.async {
                    onError(.networkError(error.localizedDescription))
                }
            }
        }
    }
}
