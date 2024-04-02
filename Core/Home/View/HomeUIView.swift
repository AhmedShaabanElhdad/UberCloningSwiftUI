//
//  SwiftUIView.swift
//  Uber2
//
//  Created by ahmed shaban on 24.03.2024.
//

import SwiftUI

struct HomeUIView: View {
    
    @State private var mapViewState = MapViewState.noInput
    
    var body: some View {
        ZStack(alignment: .bottom ) {
            ZStack(alignment: .top ){
                
                MapViewRepresentable(mapViewState: $mapViewState)
                    .ignoresSafeArea()
                
                if mapViewState == .searching {
                    LocationSearchView(mapViewState: $mapViewState)
                } else if mapViewState == .noInput{
                    LocationSearchActionView().padding(.top,74)
                        .onTapGesture {
                            withAnimation(.spring){
                                mapViewState = .searching
                            }
                        }
                }

                MapViewActionButton(mapViewState: $mapViewState)
                    .padding(.leading)
                    .padding(.top,4)
            }
            
            if mapViewState == .locationSelected {
                RequestTripView()
                    .transition(.move(edge: .bottom))
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    HomeUIView()
}
