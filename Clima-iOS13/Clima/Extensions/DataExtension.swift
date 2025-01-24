//
//  DataExtension.swift
//  Clima
//
//  Created by nicho@mac on 22/01/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

extension Data {
    var printPrettyJSON: Void {
        guard let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) else {
            return
        }
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else {
            return
        }
        
        print(String(data: jsonData, encoding: .utf8) ?? "Invalid JSON")
    }
    
    func decode<T: Decodable>(as type: T.Type) throws -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}
