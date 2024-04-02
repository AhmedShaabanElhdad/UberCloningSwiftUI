//
//  LocationResult.swift
//  Uber2
//
//  Created by ahmed shaban on 25.03.2024.
//

import SwiftUI

struct LocationItemCell: View {
    let title :String
    let subtitle :String
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 40,height: 40)
            
            
            VStack(alignment: .leading){
                Text(title).font(.body)
                Text(subtitle)
                    .font(.system(size:15))
                    .foregroundColor(.gray)
                
                Divider()
            }
            .padding(.horizontal,8)
            .padding(.bottom , 8)
        }
        .padding(.leading)
    }
}

#Preview {
    LocationItemCell(title: "Home", subtitle:"Sopruse pst 8 , tallin , estonia")
}
