//
//  propertyRenameTests.swift
//  
//
//  Created by 蒋艺 on 2023/7/5.
//

import XCTest
@testable import XibConverter

final class propertyRenameTests: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    func testTextView() {
        let tag = "textView"
        let keys = [
            "clipsSubviews",
            "multipleTouchEnabled",
            "scrollEnabled",
        ]
        
        XCTAssertEqual("clipsToBounds", UIDeclarationsGenerator.uikitPropertyName(tag, keys[0]))
        XCTAssertEqual("isMultipleTouchEnabled", UIDeclarationsGenerator.uikitPropertyName(tag, keys[1]))
        XCTAssertEqual("isScrollEnabled", UIDeclarationsGenerator.uikitPropertyName(tag, keys[2]))
    }
    
    func testStringUtility() {
        let testSource1 = "a"
        let testSource2 = "A"
        let testSource3 = ""
        XCTAssertEqual("A", testSource1.capitalizeFirstLetter())
        XCTAssertEqual("a", testSource2.lowerFirstLetter())
        XCTAssertEqual("", testSource3.capitalizeFirstLetter())
    }

}
