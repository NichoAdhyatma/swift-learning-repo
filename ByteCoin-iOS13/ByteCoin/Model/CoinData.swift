//
//  CoinData.swift
//  ByteCoin
//
//  Created by nicho@mac on 25/01/25.
//  Copyright © 2025 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    let time: String
    let assetIdBase: String
    let assetIdQuote: String
    let rate: Double
    
    enum CodingKeys: String, CodingKey {
        case time
        case assetIdBase = "asset_id_base"
        case assetIdQuote = "asset_id_quote"
        case rate
    }
}
