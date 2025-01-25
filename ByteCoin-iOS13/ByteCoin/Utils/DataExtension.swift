//
//  DataExtension.swift
//  ByteCoin
//
//  Created by nicho@mac on 25/01/25.
//  Copyright © 2025 The App Brewery. All rights reserved.
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
        
        let formatedJSON = String(data: jsonData, encoding: .utf8) ?? "Invalid JSON"
        
        print("JSON Result : \n\(formatedJSON)\n")
    }
    
    func decode<T: Decodable>(as type: T.Type) -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}
