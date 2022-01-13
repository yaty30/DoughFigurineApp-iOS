//
//  MobileAssignmentTests.swift
//  MobileAssignmentTests
//
//  Created by James Yip on 1/1/2022.
//

import XCTest
@testable import MobileAssignment

class MobileAssignmentTests: XCTestCase {

    var app: XCUIApplication = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launchArguments += ["-NSDoubleLocalizedStrings", "YES"]
        app.launch()
    }
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        app.buttons["firstTakeFVbtn"].tap()
        app.buttons["firstTakeBVbtn"].tap()
        app.buttons["firstTakeTVbtn"].tap()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
