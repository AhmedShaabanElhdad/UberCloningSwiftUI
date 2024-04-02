//
//  RideType.swift
//  Uber2
//
//  Created by ahmed shaban on 01.04.2024.
//

import Foundation

enum RideType:Int,CaseIterable,Identifiable {
    case uberX
    case black
    case uberXL
    case uberConfort
    
    var id:Int { return rawValue }
    
    var description: String {
        switch self {
            case .uberX: return "UberX"
            case .black: return "UberBlack"
            case .uberXL : return "UberXL"
            case .uberConfort : return "UberConfort"
        }
    }
    
    var imageName: String {
        switch self {
            case .uberX: return "car.side.fill"
            case .black: return "bolt.car.circle.fill"
            case .uberXL : return "car.circle.fill"
            case .uberConfort : return "steeringwheel.circle.fill"
        }
    }
    
    var baseFare: Double {
        switch self {
        case .uberX: return 5
        case .black: return 20
        case .uberXL : return 10
        case .uberConfort : return 13
        }
    }
    
    func computePrice(for distanceInMilles:Double) -> Double{
        switch self {
        case .uberX: return distanceInMilles * 1.5 + baseFare
        case .black: return distanceInMilles * 2.0 + baseFare
        case .uberXL : return distanceInMilles * 1.75 + baseFare
        case .uberConfort : return distanceInMilles * 1.3 + baseFare
        }
    }
    
}
