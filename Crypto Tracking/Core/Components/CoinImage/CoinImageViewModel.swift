//
//  CoinImageViewModel.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 6/28/23.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isloading: Bool = false
    
    private let dataService: CoinImageService
    let coin: CoinModel
    var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscriber()
        self.isloading = true
    }
    
    func addSubscriber() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isloading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
}
