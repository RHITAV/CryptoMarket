//
//  HomeViewModel.swift
//  Crypto Market
//
//  Created by Ryan Hall on 2/10/2023.
//

import Foundation

final class HomeViewModel{
    
    var products: [CryptoResponseModel] = []
    var details : CryptoDetailsResponse?
    var chartResponse : ChartResponse?
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    var eventHandlerForDetails: ((_ event: Event) -> Void)? // Data Binding Closure
    
    func fetchCryptoList() {
        self.eventHandler?(.loading)
        APIManager.shared.request(
            modelType: [CryptoResponseModel].self,
            type: ProductEndPoint.crypto_list(page: 1)) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let products):
                    self.products = products
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    
    func fetchDetails(id: String) {
        self.eventHandlerForDetails?(.loading)
        APIManager.shared.request(
            modelType: CryptoDetailsResponse.self,
            type: ProductEndPoint.crypto_details(id: id)) { response in
                self.eventHandlerForDetails?(.stopLoading)
                switch response {
                case .success(let details):
                    self.details = details
                    self.eventHandlerForDetails?(.dataLoaded)
                case .failure(let error):
                    self.eventHandlerForDetails?(.error(error))
                }
            }
    }
    
    func fetchChartData(id: String, days: String, currency: String) {
        self.eventHandler?(.loading)
        APIManager.shared.request(
            modelType: ChartResponse.self,
            type: ProductEndPoint.crypto_chart(id: id, days: days, currency: currency)) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let response):
                    self.chartResponse = response
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandlerForDetails?(.error(error))
                }
            }
    }
}

extension HomeViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
