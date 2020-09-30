//
//  DetailsViewModel.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/30/20.
//

import Foundation
import Combine

class DetailsViewModel : ObservableObject, Identifiable {
    
    private var userModel : UserModel
    
    init(_ userModel : UserModel) {
        self.userModel = userModel
    }
}
