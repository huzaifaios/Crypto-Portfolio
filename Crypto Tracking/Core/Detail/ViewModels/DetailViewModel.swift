//
//  DetailViewModel.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 7/10/23.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStattistics: [StatisticModel] = []
    @Published var coinDescription: String? = nil
    @Published var coinHomePageURL: String? = nil
    @Published var coinRedditURL: String? = nil
    
    @Published var coin: CoinModel
    private let coinDetailDataService: CoinDetailDataService
    private var cancelabbles = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        addSubscriber()
    }
    
    private func addSubscriber() {
        coinDetailDataService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistic)
            .sink { [weak self] (returnedArrays) in
                self?.overviewStatistics = returnedArrays.oveview
                self?.additionalStattistics = returnedArrays.additional
            }
            .store(in: &cancelabbles)
        
        coinDetailDataService.$coinDetails
            .sink { [weak self] (returnedCoinDetails) in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.coinHomePageURL = returnedCoinDetails?.links?.homepage?.first
                self?.coinRedditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancelabbles)
    }
    
    private func mapDataToStatistic(coinDetail: CoinDetailModel?, coinModel: CoinModel) -> (oveview: [StatisticModel], additional: [StatisticModel]) {
        let overViewArray = overviewMapData(coinModel: coinModel)
        let additionalArray = additionalMapData(coinDetail: coinDetail, coinModel: coinModel)
        
        return (overViewArray, additionalArray)
    }
    
    private func overviewMapData(coinModel: CoinModel) -> [StatisticModel]{
        let price = coinModel.currentPrice.asCurrencyWith6Decimal()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbrevations() ?? "")
        let marketPercentChange = coinModel.marketCapChangePercentage24H
        let marketStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbrevations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        let overviewArray: [StatisticModel] = [
            priceStat, marketStat, rankStat, volumeStat
        ]
        return overviewArray
    }
    
    private func additionalMapData(coinDetail: CoinDetailModel?, coinModel: CoinModel) -> [StatisticModel] {
        let high = coinModel.high24H?.asCurrencyWith6Decimal() ?? "n/a"
        let highStat = StatisticModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimal() ?? "n/a"
        let lowStat = StatisticModel(title: "24h Low", value: low)
        
        let priceChange2 = coinModel.priceChange24H?.asCurrencyWith6Decimal() ?? "n/a"
        let pricePercentChange2 = coinModel.priceChangePercentage24H
        let priceStats = StatisticModel(title: "24h Price Change", value: priceChange2, percentageChange: pricePercentChange2)
        
        let marketCapChange2 = coinModel.marketCapChange24H?.asCurrencyWith6Decimal() ?? "n/a"
        let marketPercentChange2 = coinModel.marketCapChangePercentage24H
        let marketStats = StatisticModel(title: "24h Market Change", value: marketCapChange2, percentageChange: marketPercentChange2)
        
        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockTimeStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashingValue = coinDetail?.hashingAlgorithm ?? "n/a"
        let hashingValueStat = StatisticModel(title: "Hashing Algorithm", value: hashingValue)
        
        let additionalArray: [StatisticModel] = [
            highStat, lowStat, priceStats, marketStats, blockTimeStat, hashingValueStat
        ]
        return additionalArray
    }
}
