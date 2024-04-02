//
//  LocationSearchViewModel.swift
//  Uber2
//
//  Created by ahmed shaban on 25.03.2024.
//

import Foundation
import MapKit

class LocationSearchViewModel:NSObject,ObservableObject {
    
    @Published var result = [MKLocalSearchCompletion]()
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
    
    private let searchCompleter = MKLocalSearchCompleter()
    
    var queryFragment:String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
            print("Debug: queryFragment is \(queryFragment)")
        }
    }
    
    override init() {
        super.init()
        searchCompleter.queryFragment = queryFragment
        searchCompleter.delegate = self
    }
    
    func selectLocation(location:MKLocalSearchCompletion){
        
        locationSearch(forLocationSearchCompletion: location){ response , error in
            if let error = error {
                print("Debug: error is \(error.localizedDescription)")
                return
            }
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
            print("Debug: coordinate is \(coordinate)")
        }
    }
    
    func locationSearch(forLocationSearchCompletion locationSearch:MKLocalSearchCompletion,
                       completion:  @escaping  MKLocalSearch.CompletionHandler){
        let locationSearchReq = MKLocalSearch.Request()
        locationSearchReq.naturalLanguageQuery = locationSearch.title.appending(locationSearch.subtitle)
        MKLocalSearch(request: locationSearchReq).start(completionHandler: completion)
        
    }

}


extension LocationSearchViewModel:MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        result = completer.results
    }
}
