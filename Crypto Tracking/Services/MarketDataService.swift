//
//  MarketDataService.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 7/1/23.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    var marketSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
      marketSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] (returnedGlobalData) in
                guard let self = self else { return }
                self.marketData = returnedGlobalData.data
                self.marketSubscription?.cancel()
            }
    }
}
