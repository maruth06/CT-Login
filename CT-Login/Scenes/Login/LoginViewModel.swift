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
    
    @Published private(set) var isLoginSuccess : Bool = false
    @Published var showPassword : Bool = false
    @Published private(set) var isUserNameEmpty : Bool = false
    @Published private(set) var isPasswordEmpty : Bool = false

    init() {
        SQLiteDatabase.shared.insertUser("mockUser", "helloWorld")
    }
    
    func validateUserCredentials(_ userName: String?, _ password: String?) {
        isUserNameEmpty = false
        isPasswordEmpty = false
        var validName : String = ""
        var validPassword : String = ""
        if let name = userName {
            isUserNameEmpty = isStringEmpty(name)
            validName = name
        }
        if let password = password {
            isPasswordEmpty = isStringEmpty(password)
            validPassword = password
        }
        guard (validName != "" && validPassword != "") else { return }
        isLoginSuccess = (SQLiteDatabase.shared.queryUsers(validName, validPassword).count != 0)
    }
    
    private func isStringEmpty(_ string: String) -> Bool {
        return string.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
}
