//
//  UserAccount.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/29/20.
//

import Foundation
import CoreData

@objc(UserAccount)
class UserAccount : NSManagedObject {
    @NSManaged var userName : String
    @NSManaged var password : String
}
