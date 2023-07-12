//
//  DetailView.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 7/9/23.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    @State private var readMoreDescription: Bool = false
    
    init (coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    private let spacing: CGFloat = 30
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                    ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing: 20) {
                    // Overview
                    overviewTitle
                    Divider()
                    descriptionTitle
                    overviewGrid
                    // Aditional Details
                    additionalTitle
                    Divider()
                    additionalGrid
                    linksSection
                }
                .padding()
            }
        }
        .background(
            Color.theme.backgroundColor
                .ignoresSafeArea()
        )
        .navigationTitle("\(vm.coin.name)")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
               navBarTrailing
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(coin: dev.coin)
        }
    }
}
extension DetailView {
    private var navBarTrailing: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accentColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var descriptionTitle: some View {
        ZStack {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(readMoreDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryColor)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            readMoreDescription.toggle()
                        }
                    } label: {
                        Text(readMoreDescription ? "Read less..." : "Read more...")
                            .font(.caption)
                            .bold()
                            .padding(.vertical, 4)
                    }
                    .foregroundColor(Color.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
            }
    }
    
    private var additionalTitle: some View {
        Text("Aditional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accentColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.additionalStattistics) { stat in
                    StatisticView(stat: stat)
                }
            }
    }
    private var linksSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if
                let homeURLString = vm.coinHomePageURL,
                let url = URL(string: homeURLString) {
                Link("Read more on Web", destination: url)
            }
            
            if
                let redditURLString = vm.coinRedditURL,
                let url = URL(string: redditURLString) {
                Link("Read more on Reddit", destination: url)
            }
        }
        .font(.headline)
        .foregroundColor(Color.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
