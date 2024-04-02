//
//  MapViewRepresentable.swift
//  Uber2
//
//  Created by ahmed shaban on 24.03.2024.
//

import SwiftUI
import MapKit


struct MapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager:LocationManager = LocationManager.shared
    @EnvironmentObject var viewmodel : LocationSearchViewModel
    
    @Binding var mapViewState:MapViewState
    
    
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.isRotateEnabled = true
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        switch mapViewState {
        case .noInput:
            context.coordinator.clearMap()
            break
        case .searching:
            break
        case .locationSelected:
            if let selectedLocationCoordinate = viewmodel.selectedLocationCoordinate {
                print("Debug: selected location in mapView  \(selectedLocationCoordinate)")
                context.coordinator.addAndSelectionAnnotation(withCoordinate: selectedLocationCoordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: selectedLocationCoordinate)
            }
            break
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
}


extension MapViewRepresentable {
    
    class MapCoordinator : NSObject, MKMapViewDelegate {
        
        let parent:MapViewRepresentable
        var userLocationCoordinate:CLLocationCoordinate2D?
        var currentRegin: MKCoordinateRegion?
        init(parent:MapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            userLocationCoordinate = userLocation.coordinate
            let regin = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.latitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            self.currentRegin = regin
            parent.mapView.setRegion(regin, animated: true)
        }
        
        func addAndSelectionAnnotation (withCoordinate coordinate :CLLocationCoordinate2D){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            parent.mapView.addAnnotation(annotation)
            parent.mapView.selectAnnotation(annotation,animated: true)
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        
        func configurePolyline(withDestinationCoordinate coordinate:CLLocationCoordinate2D){
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            getDestinationRoute(from: userLocationCoordinate, to: coordinate, completion: { route in
                self.parent.mapView.addOverlay(route.polyline)
                let react = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(react), animated: true)
            })
            
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 5
            return polyline
        }
        
        func getDestinationRoute(from userLocation : CLLocationCoordinate2D,to destinationCoordinate : CLLocationCoordinate2D , completion: @escaping (MKRoute) -> Void){
            
            let userPlaceMaker = MKPlacemark(coordinate: userLocation)
            let destinationPlaceMaker = MKPlacemark(coordinate: destinationCoordinate)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlaceMaker)
            request.destination = MKMapItem(placemark: destinationPlaceMaker)
            let direction = MKDirections(request: request)
            direction.calculate { response, error in
                if let _ = error {
                    return
                }
                guard let route = response?.routes.first else { return }
                completion(route)
            }
        }
        
        
        func clearMap(){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            if let currentRegin = currentRegin {
                parent.mapView.setRegion(currentRegin, animated: true)
            }
            
        }
    }
}
