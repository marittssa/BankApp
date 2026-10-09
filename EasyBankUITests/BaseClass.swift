//
//  BaseClass.swift
//  EasyBankUITests
//
//  Created by lmosakhlishvili on 10.02.25.
//


import XCTest

class BaseClass: XCTestCase {

    private(set) var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()

        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("UI-Testing")
        app.launch()
    }
}

