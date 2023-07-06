//
//  File 2.swift
//  
//
//  Created by 蒋艺 on 2023/7/4.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        if self.count < 1 {
            return self
        }
        return prefix(1).capitalized + dropFirst()
    }
    
    func lowerFirstLetter() -> String {
        if self.count < 1 {
            return self
        }
        return self.prefix(1).lowercased() + dropFirst()
    }
}

