//
//  NetworkRepository.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/30/20.
//

import Foundation

class APIRepository {
    
    class Details {
        static func userList() -> AppEndpoint<[UserModel]> {
            return AppEndpoint(
                urlString: "https://jsonplaceholder.typicode.com/users",
                httpMethod: .GET,
                timeout: 10)
        }
    }
}
