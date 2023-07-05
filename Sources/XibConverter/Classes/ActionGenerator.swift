//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/7/5.
//

import Foundation

struct Action {
    let name: String
}

class ActionGenerator {
    static public func actionString(name: String) -> String {
        """
        @objc private func \(name)() {
            print("call \\(#file) as \\(#line)")
        }
        """
    }
    
    static public func generate(with actions: [Action] ) -> String {
        return actions.map { action in
            actionString(name: action.name)
        }.reduce("") { partialResult, str in
            partialResult + "\n\n" + str
        }
    }
}
