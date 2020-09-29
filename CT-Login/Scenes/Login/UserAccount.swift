//
//  UserAccount.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/29/20.
//

import Foundation

struct UserAccount {
    var userName : String
    var userId : Int
    
    init(id: Int, name: String) {
        self.userName = name
        self.userId = id
    }
}
