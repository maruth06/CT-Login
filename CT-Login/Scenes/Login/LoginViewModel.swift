//
//  LoginViewModel.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/29/20.
//

import Foundation
import Combine

class LoginViewModel : ObservableObject, Identifiable {
    
    var countries: [String] {
        var list : [String] = []
        for code in NSLocale.isoCountryCodes  {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            list.append(name)
        }
        return list
    }

    init() {
        
    }
}
