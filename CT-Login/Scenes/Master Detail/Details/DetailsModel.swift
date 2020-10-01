//
//  DetailsModel.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 10/1/20.
//

import Foundation

struct DetailsModel {

    var name : String
    var username : String
    var email : String
    var phone : String
    var address : String
    var company : String
    var latitude : Double
    var city : String
    var longitude : Double
    
    init() {
        name = ""
        username = ""
        email = ""
        phone = ""
        address = ""
        company = ""
        latitude = 0.0
        longitude = 0.0
        city = ""
    }
    
    init(_ userModel : UserModel) {
        name = userModel.name
        username = userModel.username
        email = userModel.email
        phone = userModel.phone
        address = userModel.address.street + ", " + userModel.address.city
        company = userModel.company.name
        city = userModel.address.city
        latitude = userModel.address.geo.lat.toDouble
        longitude = userModel.address.geo.lng.toDouble
        print(latitude)
        print(longitude)
    }
}
