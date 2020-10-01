//
//  DetailsViewModel.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/30/20.
//

import Foundation
import Combine
import CoreLocation
import MapKit

class DetailsViewModel : ObservableObject, Identifiable {
    
    @Published private(set) var detailsModel : DetailsModel
    
    var region : MKCoordinateRegion {
        let coordinate = CLLocationCoordinate2D(latitude: detailsModel.latitude,
                                                longitude: detailsModel.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        return MKCoordinateRegion(center: coordinate, span: span)
        
    }
    
    var pointAnnotation : MKPointAnnotation{
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: detailsModel.latitude,
                                                longitude: detailsModel.longitude)
        pin.title = detailsModel.city
        pin.subtitle = detailsModel.address
        return pin
    }
    
    init() {
        self.detailsModel = DetailsModel()
    }
    
    func updateDetailsModel(_ detailsModel : DetailsModel) {
        self.detailsModel = detailsModel
    }
}
