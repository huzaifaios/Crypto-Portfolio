//
//  SettingsView.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 7/12/23.
//

import SwiftUI

struct SettingsView: View {
    
    let deafaultURL: URL = URL(string: "https://www.google.com")!
    let youtubeURL: URL = URL(string: "https://www.youtube.com")!
    let linkDinProfile: URL = URL(string: "https://www.linkedin.com/in/huzaifa-munawar-a49564182/")!
    let gitHubprofile: URL = URL(string: "https://github.com/huzaifaios/")!
    let coinGekoURL: URL = URL(string: "https://www.coilet")!
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.backgroundColor
                    .ignoresSafeArea()
                List {
                    intoView
                        .listRowBackground(Color.theme.backgroundColor)
                    coinGeckoinfo
                        .listRowBackground(Color.theme.backgroundColor)
                    developerOption
                        .listRowBackground(Color.theme.backgroundColor)
                    applicationOption
                        .listRowBackground(Color.theme.backgroundColor)
                }
            }
            .font(.headline)
            .foregroundColor(Color.blue)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
extension SettingsView {
    private var intoView: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by Huzaifa Munawar for self learning purpose. It uses MVVM Architecture, Combine and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accentColor)
            }
            .padding(.vertical)
            Link("Visit Google", destination: deafaultURL)
            Link("Visit Youtube", destination: youtubeURL)
            
        } header: {
            Text("Crypto Trackings")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(Color.theme.accentColor)
        }
    }
    private var coinGeckoinfo: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app uses a free API which comes from CoinGecko!. Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accentColor)
            }
            .padding(.vertical)
            Link("Visit Coingecko", destination: coinGekoURL)
            
        } header: {
            Text("Coingecko")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(Color.theme.accentColor)
        }

    }
    private var developerOption: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100 ,height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed for learning purpose to learn about Subscribers/publishers, benifits of multi-threading and data persistance")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accentColor)
            }
            .padding(.vertical)
            Link("Visit LinkdIn", destination: linkDinProfile)
            Link("Visit Github", destination: gitHubprofile)
            
        } header: {
            Text("Developer")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(Color.theme.accentColor)
        }
    }
    private var applicationOption: some View {
        Section {
            Link("Terms of Service", destination: deafaultURL)
            Link("Privacy Policy", destination: deafaultURL)
            Link("Company Website", destination: deafaultURL)
            Link("Learn More", destination: deafaultURL)
            
        } header: {
            Text("Application")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(Color.theme.accentColor)
        }
    }
}
