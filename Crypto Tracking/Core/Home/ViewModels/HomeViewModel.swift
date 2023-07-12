//
//  HomeViewModel.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 6/26/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var sortOptions: SortOption = .holdings
    
    private let coinDataService = CoinDataServices()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, price, priceReversed, holdings, hodingsReversed
    }
    
    
    init () {
        addSubscribers()
    }
        func addSubscribers() {
            // Updates allCoins
            $searchText
                .combineLatest(coinDataService.$allCoins, $sortOptions)
                .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
                .map(filteredAndSorted)
                .sink { [weak self] (returnedCoins) in
                    self?.allCoins = returnedCoins
                }
                .store(in: &cancellables)
            
            // update portfolioData and we are using filtered coins for that
            $allCoins
                .combineLatest(portfolioDataService.$savedEntities)
                .map(mapAllCoinsToPortfolioCoins)
                .sink { [weak self] (returnedCoins) in
                    guard let self = self else { return }
                    self.portfolioCoins = sortPortfolioCoinsIfNeeded(coin: returnedCoins)
                }
                .store(in: &cancellables)
            
            // Updates marketData
            marketDataService.$marketData
                .combineLatest($portfolioCoins)
                .map(mapGlobalMarketData)
                .sink { [weak self] returnedStatistic in
                    self?.statistics = returnedStatistic
                    self?.isLoading = false
                }
                .store(in: &cancellables)
        }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    private func filteredAndSorted(text: String, coin: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coin: coin)
         sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
   private func filterCoins(text: String, coin: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coin
        }
        let loweredCasedText = text.lowercased()
        
        let filteredCoin = coin.filter { (coin) in
            return coin.name.lowercased().contains(loweredCasedText) ||
            coin.symbol.lowercased().contains(loweredCasedText) ||
            coin.id.lowercased().contains(loweredCasedText)
        }
        return filteredCoin
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank,.holdings:
             coins.sort(by: { $0.rank < $1.rank })
case .rankReversed,.hodingsReversed:
             coins.sort(by: { $0.rank > $1.rank })
        case .price:
             coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
             coins.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coin: [CoinModel]) -> [CoinModel] {
        switch sortOptions {
        case .holdings:
            return coin.sorted(by: { $0.currentHoldingAmount > $1.currentHoldingAmount })
        case .hodingsReversed:
            return coin.sorted(by: { $0.currentHoldingAmount < $1.currentHoldingAmount })
        default:
             return coin
        }
    }
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateCurrentHolding(amount: entity.amount)
            }
    }
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, coins: [CoinModel]) -> [StatisticModel] {
        
        var stats: [StatisticModel] = []

        guard let data = marketDataModel else {
              return stats
          }
          let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
          let volume = StatisticModel(title: "24h Volume", value: data.volume)
          let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
          
          let portfolioValue =
              portfolioCoins
                  .map({ $0.currentHoldingAmount})
                  .reduce(0, +)
          
          let previousValue = portfolioCoins.map { (coin) -> Double in
              let currentValue = coin.currentHoldingAmount
              let percentChange = coin.priceChangePercentage24H ?? 0/100
              let previousValue = currentValue / (1 + percentChange)
              return previousValue
          }
              .reduce(0, +)
          
  //        (New Price - Old Price)/Old Price and then multiply that number by 100
          let percentageChange = ((portfolioValue - previousValue) / previousValue)
              
          let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimal(), percentageChange: percentageChange)
          
        stats.append(contentsOf: [
        marketCap, volume, btcDominance, portfolio
        ])
          return stats
    }
}
