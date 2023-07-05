//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/7/5.
//

import Foundation
import XCTest
@testable import XibConverter

final class ActionTests: XCTestCase {
    func testSelectors() {
        let actions: [Action] = [
            Action(name: "selector1"),
            Action(name: "selector2")
        ]
        
        let result = ActionGenerator.generate(with: actions)
        
        XCTAssertEqual(
            result, """
            
            
            @objc private func selector1() {
                print("call \\(#file) as \\(#line)")
            }
            
            @objc private func selector2() {
                print("call \\(#file) as \\(#line)")
            }
            """
        )
        
    }
}
