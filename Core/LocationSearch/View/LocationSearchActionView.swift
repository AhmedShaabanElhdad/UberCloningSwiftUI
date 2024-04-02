//
//  LocationSearchView.swift
//  Uber2
//
//  Created by ahmed shaban on 25.03.2024.
//

import SwiftUI

struct LocationSearchActionView: View {
    var body: some View {
        HStack{
            Rectangle().fill(Color.black)
                .frame(width: 8,height: 8)
                .padding(.horizontal)
            
            Text("What is Your Destination ?")
                .foregroundColor(Color(.darkGray))
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 45)
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(radius: 6)
        )
    }
}

#Preview {
    LocationSearchActionView()
}
