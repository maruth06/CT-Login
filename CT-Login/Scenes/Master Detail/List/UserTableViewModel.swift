//
//  UserTableViewModel.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/30/20.
//

import Foundation
import Combine

class UserTableViewModel : ObservableObject, Identifiable {
    
    @Published private(set) var dataSource : [UserModel]
    @Published private(set) var errorModel : ErrorModel?
    
    init() {
        dataSource = []
    }
    
    func fetchUsers() {
        NetworkRequest.shared.request(type: APIRepository.Details.userList()) { [weak self] (results) in
            guard let self = self else { return }
            switch results {
            case.success(let users):
                self.dataSource = users
                break
            case .failure(let errorModel):
                self.errorModel = errorModel
                break
            }
        }
    }
    
    func getItemModel(_ row : Int) -> ItemModel {
        return dataSource[row].toItemModel()
    }
}
