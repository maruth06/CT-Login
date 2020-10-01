//
//  LoginTest.swift
//  CT-LoginTest
//
//  Created by Mac Mini 2 on 9/29/20.
//

import XCTest
@testable import CT_Login

class LoginTest: XCTestCase {

    func testUserLoginSuccess() {
        let viewModel = LoginViewModel()
        viewModel.validateUserCredentials("mockUser", "helloWorld")
        XCTAssertFalse(viewModel.isUserNameEmpty!, "Username field is not empty.")
        XCTAssertFalse(viewModel.isPasswordEmpty!, "Password field is not empty.")
        XCTAssertTrue(viewModel.isLoginSuccess!, "User credentials is valid and stored in database.")
    }

    func testUserInvalidInputs() {
        let viewModel = LoginViewModel()
        viewModel.validateUserCredentials(nil, nil)
        XCTAssertFalse(viewModel.isUserNameEmpty!, "Username field is empty.")
        XCTAssertFalse(viewModel.isPasswordEmpty!, "Password field is empty.")
        XCTAssertFalse(viewModel.isLoginSuccess!, "User credentials is invalid")
    }
    
    func testDBUserQuery(){
        XCTAssertEqual(SQLiteDatabase.shared.queryUsers("testUser", "password").count, 0)
        XCTAssertEqual(SQLiteDatabase.shared.queryUsers("mockUser", "helloWorld").count, 1)
    }
}
