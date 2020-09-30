//
//  MKMapView+Extensions.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/30/20.
//

import Foundation
import MapKit

extension MKMapView {
    
    func center( _ location: CLLocation, regionRadius: CLLocationDistance = 100) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
