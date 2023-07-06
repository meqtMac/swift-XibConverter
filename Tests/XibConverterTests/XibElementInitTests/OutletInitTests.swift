//
//  OutletInitTests.swift
//
//
//  Created by 蒋艺 on 2023/7/6.
//

import XCTest
@testable import XibConverter

final class OutletInitTests: XCTestCase {
   
    func testExample() throws {
        let expectedTestCases: [[String: String]] = [
            ["property": "acceptContainView",
                "destination": "Olm-Jm-QjG",
                "id": "ZZC-Vd-Sy1" ],
            ["property": "acceptManName",
                "destination": "22x-Pw-WeO",
                "id": "Rks-1Z-TNB"],
            ["property": "acceptedContentTextView",
                "destination": "USG-gL-ltI",
                "id": "IxW-Uu-DzD"]
        ]
        
        
        for testCase in expectedTestCases {
            let outlet = try XibOutlet(attributes: testCase)
            XCTAssertEqual(testCase["property"], outlet.property)
            XCTAssertEqual(testCase["destination"], outlet.destination)
            XCTAssertEqual(testCase["id"], outlet.id)
        }
        
        
    }
    
    func testMissingAttribute() throws {
        let testCase = ["property": "acceptContainView",
                        "destination": "Olm-Jm-QjG"]
        XCTAssertThrowsError(try XibOutlet(attributes: testCase))
    }
    
}
