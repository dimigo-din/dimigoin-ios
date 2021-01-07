//
//  DimigoinUITests.swift
//  DimigoinUITests
//
//  Created by 변경민 on 2021/01/07.
//  Copyright © 2021 seohun. All rights reserved.
//

import XCTest

class UI_tests_for_screenshots: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        let screenshot = XCUIScreen.main.screenshot()
    }


    func test_login() throws {
        let app = XCUIApplication()
        app.launchArguments.append("UITesting")
        app.launch()
        
        let usernameTextField = app.textFields["textfield.username"]
        usernameTextField.tap()
        usernameTextField.typeText("dimigofrontdev")
        
        let passwordTextField = app.secureTextFields["textfield.password"]
        passwordTextField.tap()
        passwordTextField.typeText("dimigofrontdev")
        
        let loginButton = app.buttons["button.login"]
        loginButton.tap()
    }

    
}
