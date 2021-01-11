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

    func test_ui_for_snapshot_without_widget() throws {
        let app = XCUIApplication()
        app.launchArguments.append(contentsOf: ["UITesting", "Lightmode"])
        setupSnapshot(app)
        app.launch()
        
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            XCUIDevice.shared.orientation = UIDeviceOrientation.portrait;
//        }
        
        let usernameTextField = app.textFields["textfield.username"]
        usernameTextField.tap()
        usernameTextField.typeText("dimigofrontdev")

        let passwordTextField = app.secureTextFields["textfield.password"]
        passwordTextField.tap()
        passwordTextField.typeText("dimigofrontdev")
        // MARK: 이곳에서 오류가 난다면 simulator의 'Hardware -> Keyboard -> Connect hardware keyboard'를 꺼주세요.
        
        let loginButton = app.buttons["button.login"]
        loginButton.tap()

        let showIdCardButton = app.buttons["button.showIdCard"]
        showIdCardButton.tap()

        snapshot("4-MobileIDCard")

        let dismissIdCardButton = app.buttons["button.dismissIdCard"]
        dismissIdCardButton.tap()

        let tabBarButtonIngang = app.buttons["tapbar.ingang"]
        tabBarButtonIngang.tap()

        snapshot("3-Ingang")

        let tabBarButtonMeal = app.buttons["tapbar.meal"]
        tabBarButtonMeal.tap()

        snapshot("1-Meal")

        let tabBarButtonTimetable = app.buttons["tapbar.timetable"]
        tabBarButtonTimetable.tap()

        snapshot("2-Timetable")
    }
    
    func test_darkmode() throws {
        let app = XCUIApplication()
        app.launchArguments.append(contentsOf: ["UITesting", "Darkmode"])
        setupSnapshot(app)
        app.launch()
        
        let usernameTextField = app.textFields["textfield.username"]
        usernameTextField.tap()
        usernameTextField.typeText("dimigofrontdev")
        
        let passwordTextField = app.secureTextFields["textfield.password"]
        passwordTextField.tap()
        passwordTextField.typeText("dimigofrontdev")
        
        let loginButton = app.buttons["button.login"]
        loginButton.tap()
        
        snapshot("6-Darkmode")
    }
}
