//
//  CoordinatorView.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 7/10/23.
//

import SwiftUI

struct CoordinatorView: View {
    
    @StateObject var coordinator: Coordinator = Coordinator()
    let coin: CoinModel
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(coinPage: .CoinPage, coin: coin)
                .navigationDestination(for: CoinPage.self) { coinPage in
                    coordinator.build(coinPage: coinPage, coin: coin)
                }
        }
        .environmentObject(coordinator)
    }
}

struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatorView(coin: dev.coin)
    }
}
