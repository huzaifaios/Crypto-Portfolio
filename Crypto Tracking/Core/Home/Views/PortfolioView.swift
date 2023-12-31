//
//  PortfolioView.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 7/5/23.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                SearchBarView(searchText: $vm.searchText)
                coinLogoList
                
                if selectedCoin != nil {
                    portfolioInputSection
                }
            }
            .background(
                Color.theme.backgroundColor
                    .ignoresSafeArea()
            )
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButtons
                    
                }
            }
            .onChange(of: vm.searchText) { value in
                if value == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.theme.secondaryColor.opacity(0.25), lineWidth: 1)
                        }
                        .onTapGesture {
                            withAnimation(.spring()) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(selectedCoin?.id == coin.id ? Color.theme.secondaryColor.opacity(0.2) : Color.clear)
                        }
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    private func updateSelectedCoin (coin: CoinModel) {
        selectedCoin = coin

        if selectedCoin == coin {
            UIApplication.shared.endEdititng()
        }

       if
          let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}),
          let amount = portfolioCoin.currentHoldings {
           quantityText = "\(amount)"
       } else {
           quantityText = ""
       }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
                HStack {
                    Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                    Spacer()
                    Text(selectedCoin?.currentPrice.asCurrencyWith6Decimal() ?? "")
                }
                Divider()
                HStack {
                    Text("Portfolio Amount:")
                    Spacer()
                    TextField("Ex: 1.4", text: $quantityText)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                Divider()
                HStack {
                    Text("Current Value:")
                    Spacer()
                    Text(getCurrentValue().asCurrencyWith2Decimal())
                }
        }
        .padding()
        .animation(.none, value: selectedCoin)
        .font(.headline)

    }
    
    private var trailingNavBarButtons: some View {
        HStack {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
                    .opacity(
                        (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
                    )
            }

        }
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
            else { return }

        // save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        //show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
            
        // hide Keyboard
            UIApplication.shared.endEdititng()
            
        // hide checkmark
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeOut) {
                    showCheckmark = false
                }
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}
