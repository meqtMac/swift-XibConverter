//
//  ActionInitTests.swift
//
//
//  Created by 蒋艺 on 2023/7/6.
//

import XCTest
@testable import XibConverter

final class ActionInitTests: XCTestCase {
    
   func testActionInit() throws {
       let attributes1: [String: String] = [
            "selector": "buttonTapped",
            "destination": "ViewController",
            "eventType": "touchUpInside",
            "id": "action1"
        ]
        XCTAssertNoThrow(try XibAction(attributes: attributes1))
        
        // Case 2: Missing attribute
        let attributes2: [String: String] = [
            "selector": "buttonTapped",
            "destination": "ViewController",
            // Missing "eventType" attribute
            "id": "action2"
        ]
        XCTAssertThrowsError(try XibAction(attributes: attributes2)) { error in
            XCTAssertTrue(error is XibElementInitError)
        }
        
        // Case 3: Undefined eventType
        let attributes3: [String: String] = [
            "selector": "buttonTapped",
            "destination": "ViewController",
            "eventType": "unknownEventType",
            "id": "action3"
        ]
        XCTAssertThrowsError(try XibAction(attributes: attributes3)) { error in
            XCTAssertTrue(error is XibElementInitError)
        }
    }
    
   
}
