//
//  MarketDataModel.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 7/1/23.
//

import Foundation

// JOSN Data:
/*
 URL: https://api.coingecko.com/api/v3/global

JSON Response:
 {
 "data": {
   "active_cryptocurrencies": 9882,
   "upcoming_icos": 0,
   "ongoing_icos": 49,
   "ended_icos": 3376,
   "markets": 767,
   "total_market_cap": {
     "btc": 40578555.58660457,
     "eth": 644472556.1138337,
     "ltc": 11128510535.724041,
     "bch": 4168541060.3282685,
     "bnb": 5075332487.449892,
     "eos": 1571040207917.621,
     "xrp": 2629659991085.5547,
     "xlm": 11543633251406.352,
     "link": 198492075378.50696,
     "dot": 233540208970.3653,
     "yfi": 188025252.08876288,
     "usd": 1235790170483.6814,
     "aed": 4539088190940.804,
     "ars": 316982246206019.5,
     "aud": 1854735677370.4312,
     "bdt": 133695253466085.47,
     "bhd": 465422058217.3949,
     "bmd": 1235790170483.6814,
     "brl": 5919187758582.746,
     "cad": 1637211891561.8953,
     "chf": 1105709661348.3975,
     "clp": 990448747937554.5,
     "cny": 8964051159637.492,
     "czk": 26910072436384.46,
     "dkk": 8433588228957.371,
     "eur": 1132045585671.577,
     "gbp": 972565628380.4866,
     "hkd": 9684455039520.945,
     "huf": 422269501254275.44,
     "idr": 18586654901125704,
     "ils": 4583990626785.357,
     "inr": 101453736311990.73,
     "jpy": 178367685119216.9,
     "krw": 1626671556673472.2,
     "kwd": 379980761620.32227,
     "lkr": 380665398025301.56,
     "mmk": 2595316328083185.5,
     "mxn": 21162041616413.684,
     "myr": 5768050620732.58,
     "ngn": 939534192913627.8,
     "nok": 13273127905097.033,
     "nzd": 2013329573109.2874,
     "php": 68307064647524.71,
     "pkr": 354053883843574.44,
     "pln": 5022345172898.622,
     "rub": 109770306333914.53,
     "sar": 4635210421981.385,
     "sek": 13338995521183.824,
     "sgd": 1671035468528.0322,
     "thb": 43530675388953.19,
     "try": 32193693310287.418,
     "twd": 38508828239493.13,
     "uah": 45643366199139.55,
     "vef": 123739669770.53082,
     "vnd": 29136842744578980,
     "zar": 23258009714013.387,
     "xdr": 926888352099.0687,
     "xag": 54270367947.679344,
     "xau": 643797247.2151767,
     "bits": 40578555586604.57,
     "sats": 4057855558660457.5
   },
   "total_volume": {
     "btc": 2171981.634422561,
     "eth": 34495623.00908251,
     "ltc": 595657488.3618993,
     "bch": 223122644.3249294,
     "bnb": 271658978.2946421,
     "eos": 84090486445.57726,
     "xrp": 140753487226.12183,
     "xlm": 617877079509.4767,
     "link": 10624359001.15808,
     "dot": 12500322829.388428,
     "yfi": 10064118.558209065,
     "usd": 66146108837.26323,
     "aed": 242956311411.98767,
     "ars": 16966587579198.104,
     "aud": 99275387448.4064,
     "bdt": 7156086039535.27,
     "bhd": 24911881364.18131,
     "bmd": 66146108837.26323,
     "brl": 316826632108.7239,
     "cad": 87632349370.87143,
     "chf": 59183503274.944,
     "clp": 53014121849801.27,
     "cny": 479804029672.857,
     "czk": 1440371207596.7095,
     "dkk": 451410812454.4617,
     "eur": 60593143000.37501,
     "gbp": 52056921508.81731,
     "hkd": 518363903819.53906,
     "huf": 22602125389692.926,
     "idr": 994857320745089.6,
     "ils": 245359730276.5912,
     "inr": 5430347355338.961,
     "jpy": 9547193847907.543,
     "krw": 87068174193431.75,
     "kwd": 20338605545.281693,
     "lkr": 20375250952600.305,
     "mmk": 138915230436997.27,
     "mxn": 1132705811561.9456,
     "myr": 308736962997.92596,
     "ngn": 50288902165706.07,
     "nok": 710448896577.5096,
     "nzd": 107764182179.92793,
     "php": 3656159953724.772,
     "pkr": 18950860181875.9,
     "pln": 268822813418.90854,
     "rub": 5875494726601.497,
     "sar": 248101288049.56873,
     "sek": 713974484178.5364,
     "sgd": 89442768369.74724,
     "thb": 2329994897847.6646,
     "try": 1723178895930.4272,
     "twd": 2061198741310.61,
     "uah": 2443077425616.4175,
     "vef": 6623209877.875156,
     "vnd": 1559559881110572.8,
     "zar": 1244893250185.9302,
     "xdr": 49612029033.97439,
     "xag": 2904840765.5650005,
     "xau": 34459476.85986055,
     "bits": 2171981634422.561,
     "sats": 217198163442256.12
   },
   "market_cap_percentage": {
     "btc": 47.84984265534008,
     "eth": 18.66253777261897,
     "usdt": 6.741640896615815,
     "bnb": 3.076220308146237,
     "usdc": 2.2170220739933235,
     "xrp": 1.9873710689200463,
     "steth": 1.1652832818227399,
     "ada": 0.8115359316580673,
     "doge": 0.7763142453237082,
     "ltc": 0.6563975716333468
   },
   "market_cap_change_percentage_24h_usd": 0.02851046655500286,
   "updated_at": 1688204727
 }
}

 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    // For TotalMarketCap
    var marketCap: String {
        if let item = totalMarketCap.first(where: { (key,value) in
            key == "usd"
        }) {
            return "$" + item.value.formattedWithAbbrevations()
        } else {
            return ""
        }
    }
    
    // For TotalVolume
    var volume: String {
        if let item = totalVolume.first(where: { (key, value) in
            key == "usd"
        }) {
            return "$" + item.value.formattedWithAbbrevations()
        } else {
            return ""
        }
    }
    
    // For MarketCapPercentage
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { (key, value) in
            key == "btc"
        }) {
            return item.value.asPercentString()
        } else {
            return ""
        }
    }
}
