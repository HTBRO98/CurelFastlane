//
//  CurelFaslaneUITests.swift
//  CurelFaslaneUITests
//
//  Created by HAYATOYAMAMOTo on 2021/03/07.
//

import XCTest

class CurelFaslaneUITests: XCTestCase {

    func testExample() throws {
        // 1
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        snapshot("01LoginScreen")
        
//        // 2
//        let chipCountTextField = app.textFields["chip count"]
//        chipCountTextField.tap()
//        chipCountTextField.typeText("10")
        // 3
//        let bigBlindTextField = app.textFields["big blind"]
//        bigBlindTextField.tap()
//        bigBlindTextField.typeText("100")
        // 4
//        snapshot("01UserEntries")
        // 5
//        app.buttons["what should i do"].tap()
//        snapshot("02Suggestion")
    }

}
