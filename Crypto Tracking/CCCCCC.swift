//
//  CCCCCC.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 6/25/23.
//

import SwiftUI

struct Platform: Hashable {
    let name: String
    let imageNmae: String
    let color: Color
}

struct Games: Hashable {
    let name: String
    let Points: String
}

struct CCCCCC: View {
    
    var platforms: [Platform] = [
    Platform(name: "Xbox", imageNmae: "heart.fill", color: Color.red),
    Platform(name: "Playstation", imageNmae: "globe", color: Color.brown),
    Platform(name: "Mac", imageNmae: "heart.fill", color: .gray)
    ]
    
    var games: [Games] = [
    Games(name: "PUBG", Points: "10"),
    Games(name: "FreeFire", Points: "9"),
    Games(name: "CandyCrush", Points: "8")
    ]
        
    @State private var path = NavigationPath()
    
    var body: some View {
       NavigationStack(path: $path)  {
            List {
                Section("Machine") {
                    ForEach(platforms, id: \.name) { item in
                      NavigationLink(value: item)  {
                            
                            Label(item.name, systemImage: item.imageNmae)
                                .foregroundColor(item.color)
                        }
                            
                    }
                }
                Section("Games") {
                    ForEach(games, id: \.name) { item in
                        NavigationLink(value: item) {
                            Text(item.name)
                        }
                    }

                }
                
                
                
            }
            .navigationTitle("NavigationStack")
            .navigationDestination(for: Platform.self) { value in
                ZStack {
                    value.color
                        .ignoresSafeArea()
                    
                    VStack {
                        Label(value.name, systemImage: value.imageNmae)
                            .font(.largeTitle)
                        List {
                            ForEach(games, id: \.name) { item in
                                NavigationLink(value: item) {
                                    Text(item.name)
                                }
                            }
                        }
                    }
                }
                
            }
            .navigationDestination(for: Games.self) { value in
                VStack(spacing: 20) {
                    Text("\(value.name) - \(value.Points)")
                        .font(.largeTitle)
                    
                    Button("Random Game") {
                        path.append(games.randomElement()!)
                        }
                    
                    Button("Random Machine") {
                        path.append(platforms.randomElement()!)
                    }
                    
                    Button("Go Home") {
                        path.removeLast(path.count)
                    }

                    }
                    
                }
            }
           
        }
    }


struct NavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        CCCCCC()
    }
}
