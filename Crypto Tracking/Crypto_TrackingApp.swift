//
//  Crypto_TrackingApp.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 6/23/23.
//

import SwiftUI

@main
struct Crypto_TrackingApp: App {
    
    @StateObject private var vm = HomeViewModel()
    @State private var showlaunchScreen: Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accentColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accentColor)]
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .toolbar(.hidden, for: .navigationBar)
                }
                .navigationViewStyle(.stack)
                .environmentObject(vm)
                ZStack {
                    
                    if showlaunchScreen {
                        LaunchView(showLaunchScreen: $showlaunchScreen)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
                    
        }
    }
}
