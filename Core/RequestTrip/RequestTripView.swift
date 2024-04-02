//
//  RequestTripView.swift
//  Uber2
//
//  Created by ahmed shaban on 29.03.2024.
//

import SwiftUI

struct RequestTripView: View {
    
    @State var selectedRideType:RideType = .uberX
    
    var body: some View {
        VStack{
            Capsule()
                .frame(width: 60,height: 6)
                .foregroundColor(Color(.systemGray5))
                .padding(.top)
            
            HStack{
                VStack {
                    Circle()
                        .fill(Color(uiColor: .systemGray3))
                        .frame(width: 8,height: 8)
                    
                    Rectangle()
                        .fill(Color(uiColor: .systemGray3))
                        .frame(width: 1,height: 32)
                    
                    Rectangle()
                        .fill(Color(uiColor: .black))
                        .frame(width: 8,height: 8)
                }
                
                VStack(alignment: .leading,spacing: 24) {
                    HStack{
                        Text("Current location").font(.system(size: 16)).foregroundColor(.gray)
                        Spacer()
                        Text("11:30").font(.system(size: 16,weight: .semibold))
                    }.padding(.bottom , 10)
                    
                    HStack{
                        Text("Hotel Street").font(.system(size: 16,weight: .semibold)).foregroundColor(.black)
                        Spacer()
                        Text("12:30").font(.system(size: 16,weight: .semibold))
                    }
                }
                
            }.padding()
            
            Divider().padding(.horizontal,8)
            
            Text("Suggestion Rides".uppercased())
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray).frame(maxWidth: .infinity,alignment: .leading)
            
            
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing:15){
                    ForEach(RideType.allCases){ rideType in
                        VStack(alignment: .center){
                            Image(systemName: rideType.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: .infinity)
                            
                            VStack(alignment: .leading, spacing: 4){
                                Text(rideType.description).font(.system(size: 14,weight: .semibold))
                                    .foregroundColor(selectedRideType == rideType ? .white : .black)
                                
                                Text("220 $").font(.system(size: 14,weight: .semibold))
                                    .foregroundColor(selectedRideType == rideType ? .white : .black)
                            }
                            
                            
                        }.padding()
                            .frame(width: 112,height: 140)
                            .background(Color(selectedRideType == rideType ? .systemBlue : .systemGroupedBackground))
                            .scaleEffect(selectedRideType == rideType ? 1.2 : 1.0)
                            .cornerRadius(10)
                            .onTapGesture {
                                withAnimation(.spring()){
                                    selectedRideType = rideType
                                }
                            }
                    }
                }.padding(.horizontal)
            }
            
            Divider().padding(.vertical)
            
            HStack{
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                
                Text("****45")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName:"chevron.right")                    .imageScale(.medium)
                    .padding()
                
            }
            .frame(height : 50)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(4)
            .padding(.horizontal)
            .padding(.bottom)
            
            Button{
                
            } label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32 , height: 50)
                    .background(.blue)
                    .cornerRadius(6)
                    .foregroundColor(.white)
            }
            
        }.background(.white)
            .cornerRadius(12)
            .padding(.bottom)
    }
}

#Preview {
    RequestTripView()
}
