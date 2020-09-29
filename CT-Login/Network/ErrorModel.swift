//
//  ErrorModel.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/29/20.
//

import Foundation

class ErrorModel : Error {
    
    var statusCode : Int?
    var message : String
    
    init(_ code: Int?, _ message: String) {
        self.statusCode = code
        self.message = message
    }
    
    convenience init(_ error: Error, _ code: Int?) {
        self.init(code, error.localizedDescription)
    }
}
