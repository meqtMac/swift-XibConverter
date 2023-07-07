//
//  XibUICodeCaseTests.swift
//
//
//  Created by 蒋艺 on 2023/7/7.
//

import XCTest
@testable import XibConverter

final class XibUICodeCaseTests: XCTestCase {
    
    func testExample() throws {
        for tag in tagAttributeDicts.keys {
            XCTAssertNotNil(XibUINode(rawValue: tag))
        }
    }
    
}
