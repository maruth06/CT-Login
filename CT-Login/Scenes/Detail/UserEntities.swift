//
//  UserNetworkModel.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/30/20.
//

import Foundation

class UserModel: Codable {
    
    var id : Int
    var name : String
    var userName : String
    var email : String
    var address : AddressModel
    var phone : String
    var website : String

}

class AddressModel : Codable {

    var street : String
    var suite : String
    var city : String
    var zipcode : String
    var geo : GeoModel
}

class GeoModel : Codable {
    var lat : String
    var lng : String
}

class CompanyModel : Codable {
    var name : String
    var catchPhrase : String
    var bs : String
}
