//
//  ItemModel.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/30/20.
//

import Foundation

struct ItemModel {
    
    var name : String
    var userName : String
    var company : String
    
    init(name : String, userName: String, company: String) {
        self.name = name
        self.userName = userName
        self.company = company
    }
}
