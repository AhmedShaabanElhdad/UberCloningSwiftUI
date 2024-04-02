//
//  MapViewActionButton.swift
//  Uber2
//
//  Created by ahmed shaban on 25.03.2024.
//

import SwiftUI

struct MapViewActionButton: View {
    
    @Binding var mapViewState:MapViewState
    @EnvironmentObject var viewmodel : LocationSearchViewModel
    
    var body: some View {
        Button{
            withAnimation(.spring){
                actionForState(mapViewState)
            }
        } label: {
            Image( systemName: getImageFromViewState())
                .font(.title)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(radius: 6)
        }
        .frame(maxWidth : .infinity ,alignment: .leading)
        
    }
    
    func getImageFromViewState() -> String {
        return switch  mapViewState {
        case .noInput:
            "line.3.horizontal"
        case .searching , .locationSelected:
            "arrow.left"
        }
    }
    
    func actionForState(_ state:MapViewState){
        switch state {
            case .noInput:
                print("Debug:- No input clicked")
                break
            case .searching:
            mapViewState = .noInput
                print("Debug:- Searching clicked")
                break
            case .locationSelected:
            viewmodel.selectedLocationCoordinate = nil
            mapViewState = .noInput
                print("Debug:- Clear Input")
                break
        }
    }
}

#Preview {
    MapViewActionButton(mapViewState: .constant(.noInput))
}
