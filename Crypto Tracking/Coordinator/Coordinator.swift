//
//  Coordinator.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 7/10/23.
//

import SwiftUI

enum CoinPage: String, Identifiable {
    case CoinPage
    
    var id: String {
        self.rawValue
    }
}

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ coinPage: CoinPage) {
        path.append(coinPage)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(coinPage: CoinPage, coin: CoinModel) -> some View {
        switch coinPage {
        case .CoinPage:
            DetailView(coin: coin)
        }
    }
}
