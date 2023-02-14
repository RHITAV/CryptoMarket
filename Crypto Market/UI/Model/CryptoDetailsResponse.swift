//
//  CryptoDetailsResponse.swift
//  Crypto Market
//
//  Created by Ryan Hall on 2/10/2023
//

import Foundation

struct CryptoDetailsResponse: Codable {
    let id: String?
    let symbol, name, asset_platform_id, country_origin, contract_address: String?
    let description: DescriptionModel?
    let liquidity_score: Double?
}

struct DescriptionModel: Codable {
    let en: String?
}
