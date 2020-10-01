//
//  LoginViewModel.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/29/20.
//

import Foundation
import Combine

class LoginViewModel : ObservableObject, Identifiable {
    
    var countries: [CountryModel] {
        var list : [CountryModel] = []
        for code in Locale.isoRegionCodes  {
            guard let name = countryName(code) else { continue }
            list.append(CountryModel(code, name))
        }
        return list
    }
    
    @Published private(set) var isLoginSuccess : Bool?
    @Published private(set) var isUserNameEmpty : Bool?
    @Published private(set) var isPasswordEmpty : Bool?
    @Published private(set) var selectedCountry : String?

    @Published var showPassword : Bool = false
    @Published var isPickerViewHidden : Bool = true

    init() {
        SQLiteDatabase.shared.insertUser("mockUser", "helloWorld")
        if let regionCode = Locale.current.regionCode,
           let countryName = countryName(regionCode) {
            selectedCountry = self.countryTitle(regionCode, countryName)
        }
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

    func updateSelectedCountry(_ row: Int) {
        self.selectedCountry = countryTitle(row)
        self.isPickerViewHidden = false
    }
    
    func countryTitle(_ index: Int) -> String {
        let country = countries[index]
        let base : UInt32 = 127397
        var string = ""
        for v in country.code.uppercased().unicodeScalars {
            guard let unicode = UnicodeScalar(base + v.value) else { return country.name }
            string.unicodeScalars.append(unicode)
        }
        return string + " " + country.name
    }
    
    private func countryTitle(_ code: String, _ name: String) -> String {
        let base : UInt32 = 127397
        var string = ""
        for v in code.uppercased().unicodeScalars {
            guard let unicode = UnicodeScalar(base + v.value) else { return name }
            string.unicodeScalars.append(unicode)
        }
        return string + " " + name
    }
    
    private func isStringEmpty(_ string: String) -> Bool {
        return string.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    private func countryName(_ code: String) -> String? {
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        return NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id)
    }
}
