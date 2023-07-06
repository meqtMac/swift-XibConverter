//
//  ConstraintInitTests.swift
//
//
//  Created by 蒋艺 on 2023/7/6.
//

import XCTest
@testable import XibConverter

final class ConstraintInitTests: XCTestCase {
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testMultiplierInitHelper() throws {
        let testMultiplierStrings = [
            "1:1",
            "82:7",
            "123:7",
            "10:128"
        ]
        
        let results: [CGFloat] = [1, 82/7, 123/7, 10/128]
        
        let muliplier = try testMultiplierStrings.map { str in
            try XibConstraint.multiplerInitHelper(str)
        }
        
        XCTAssertNoThrow(
            try testMultiplierStrings.map{try XibConstraint.multiplerInitHelper($0)}
        )
        
        XCTAssertEqual(
            results,
            muliplier
        )
    }
    
    func testConstraintInit() throws {
        let testAttributes: [[String : String]] = [
            [
                "firstAttribute": "width",
                "constant": "50",
                "id": "9ac-dE-DHf"
            ],
            [
                "firstAttribute": "height",
                "constant": "16",
                "id": "AwC-AX-dCg"
            ],
            [
                "firstAttribute": "bottom",
                "secondItem": "xo2-BJ-Rzb",
                "secondAttribute": "bottom",
                "constant": "2",
                "id": "5yY-9P-clT"
            ],
            [
                "firstItem": "UfQ-FA-8fT",
                "firstAttribute": "top",
                "secondItem": "iN0-l3-epB",
                "secondAttribute": "top",
                "id": "JqQ-ue-YG9"
            ],
            [
                "firstAttribute": "width",
                "secondItem": "Fgp-vx-obw",
                "secondAttribute": "height",
                "multiplier": "265:14",
                "id": "xM4-tE-1T3"
            ]
        ]
        
        XCTAssertNoThrow {
            try testAttributes.map {
                try XibConstraint(attributes: $0)
            }
        }
        
        let constraint = try testAttributes.map {
            try XibConstraint(attributes: $0)
        }
        
        XCTAssertEqual(constraint[2].firstAttribute, .bottom)
        XCTAssertEqual(constraint[2].constant, 2)
        XCTAssertEqual(constraint[2].id, "5yY-9P-clT")
        XCTAssertEqual(constraint[2].firstItem, .baseView)
        XCTAssertEqual(constraint[2].secondItem, .id("xo2-BJ-Rzb"))
        XCTAssertEqual(constraint[2].secondAttribute, .bottom)
        XCTAssertEqual(constraint[2].multipler, 1)
        
        XCTAssertEqual(constraint[3].firstAttribute, .top)
        XCTAssertEqual(constraint[3].constant, 0)
        XCTAssertEqual(constraint[3].id, "JqQ-ue-YG9")
        XCTAssertEqual(constraint[3].firstItem, .id("UfQ-FA-8fT"))
        XCTAssertEqual(constraint[3].secondItem, .id("iN0-l3-epB"))
        XCTAssertEqual(constraint[3].secondAttribute, .top)
        XCTAssertEqual(constraint[3].multipler, 1)
        
        XCTAssertEqual(constraint[0].firstAttribute, .width)
        XCTAssertEqual(constraint[0].constant, 50)
        XCTAssertEqual(constraint[0].id, "9ac-dE-DHf")
        XCTAssertEqual(constraint[0].firstItem, .baseView)
        XCTAssertEqual(constraint[0].secondItem, .escape)
        XCTAssertEqual(constraint[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraint[0].multipler, 1)
        
        XCTAssertEqual(constraint[1].firstAttribute, .height)
        XCTAssertEqual(constraint[1].constant, 16)
        XCTAssertEqual(constraint[1].id, "AwC-AX-dCg")
        XCTAssertEqual(constraint[1].firstItem, .baseView)
        XCTAssertEqual(constraint[1].secondItem, .escape)
        XCTAssertEqual(constraint[1].secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraint[1].multipler, 1)
        
        XCTAssertEqual(constraint[4].firstAttribute, .width)
        XCTAssertEqual(constraint[4].constant, 0)
        XCTAssertEqual(constraint[4].id, "xM4-tE-1T3")
        XCTAssertEqual(constraint[4].firstItem, .baseView)
        XCTAssertEqual(constraint[4].secondItem, .id("Fgp-vx-obw"))
        XCTAssertEqual(constraint[4].secondAttribute, .height)
        XCTAssertEqual(constraint[4].multipler, CGFloat(265.0/14.0))
    }
    
}
