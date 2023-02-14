//
//  CryptoResponseModel.swift
//  Crypto Market
//
//  Created by Ryan Hall on 2/10/2023.
//

import Foundation

struct CryptoResponseModel: Codable {
    let id: String?
    let symbol: String?
    let name: String?
    let image, last_updated: String?
    let current_price, market_cap, high_24h, low_24h, price_change_24h, market_cap_change_24h, price_change_percentage_24h, market_cap_change_percentage_24h, circulating_supply, total_supply, ath_change_percentage, total_volume : Double?
    let fully_diluted_valuation : Int?
}
