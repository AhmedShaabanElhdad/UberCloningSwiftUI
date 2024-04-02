//
//  LocationSearchView.swift
//  Uber2
//
//  Created by ahmed shaban on 25.03.2024.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var startLocationString = ""
    @State private var destinationLocationString = ""
    
    @Binding var mapViewState:MapViewState
    
    @EnvironmentObject var viewmodel: LocationSearchViewModel
    
    var body: some View {
        VStack {
            
            HStack {
                VStack {
                    Circle().fill(Color(.systemGray3))
                        .frame(width: 6 ,height: 6)
                    
                    Rectangle().fill(Color(.systemGray3))
                        .frame(width: 1 ,height: 24)
                    
                    
                    Rectangle().fill(.black)
                        .frame(width: 6 ,height: 6)
                    
                }
                
                VStack {
                    TextField("Current location",
                              text: $startLocationString)
                    .frame(height: 32)
                    .background(Color(.systemGroupedBackground))
                    .padding(.trailing)
                    
                    TextField("Current location",
                              text:$viewmodel.queryFragment
                    )
                    .frame(height: 32)
                    .background(Color(.systemGray4))
                    .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top,64)
            
            
            Divider().padding(.vertical)
                .padding(.horizontal)
            
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewmodel.result , id: \.self){ result in
                        LocationItemCell(title: result.title, subtitle: result.subtitle).onTapGesture {
                            withAnimation(.spring){
                                viewmodel.selectLocation(location: result)
                                mapViewState = .locationSelected
                            }
                            
                        }
                    }
                }
            }
        }
        .background(.white)
    }
}

#Preview {
    LocationSearchView(mapViewState: .constant(.noInput))
}
