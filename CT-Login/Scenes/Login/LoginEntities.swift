//
//  UserAccount.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/29/20.
//

import Foundation

struct UserAccountEntity {
    var userName : String
    var userId : Int
    
    init(id: Int, name: String) {
        self.userName = name
        self.userId = id
    }
}

struct CountryModel {
    var code : String
    var name : String
    
    init(_ code: String, _ name: String) {
        self.code = code
        self.name = name
    }
}
