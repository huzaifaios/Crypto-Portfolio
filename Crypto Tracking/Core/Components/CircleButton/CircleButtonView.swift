//
//  CircleButtonView.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 6/25/23.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accentColor)
            .frame(width: 50, height: 50)
            .background(Circle())
            .foregroundColor(Color.theme.backgroundColor)
            .shadow(
                color: Color.theme.accentColor.opacity(0.15),
                radius: 10, x: 0, y: 0)
            .padding()
        
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            CircleButtonView(iconName: "info")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            
            CircleButtonView(iconName: "plus")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
        }
    }
}
