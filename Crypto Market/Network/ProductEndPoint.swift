//
//  ProductEndPoint.swift
//  Crypto Market
//
//  Created by Ryan Hall on 2/10/2023.
//

import Foundation

enum ProductEndPoint {
    case crypto_list(page: Int) // Module - GET
    case crypto_details(id: String) // Module - GET
    case crypto_chart(id: String, days: String, currency: String) // Module - GET
}

extension ProductEndPoint: EndPointType {
    
    var path: String {
        switch self {
        case .crypto_list(let page):
            return "/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=\(page)&sparkline=false"
        case .crypto_details(let id):
            return "/\(id)"
        case .crypto_chart(let id, let days, let currency):
            return "/\(id)/market_chart?vs_currency=\(currency)&days=\(days)"
        }
    }
    
    var baseURL: String {
        switch self {
        case .crypto_list:
            return Constant.API.BASE_URL
        case .crypto_details:
            return Constant.API.BASE_URL
        case .crypto_chart:
            return Constant.API.BASE_URL
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .crypto_list:
            return .get
        case .crypto_details:
            return .get
        case .crypto_chart:
            return .get
        }
    }
    
    var body: Encodable? {
        switch self {
        case .crypto_list:
            return nil
        case .crypto_details:
            return nil
        case .crypto_chart:
            return nil
        }
    }
    
    var headers: [String : String]? {
        APIManager.commonHeaders
    }
}

