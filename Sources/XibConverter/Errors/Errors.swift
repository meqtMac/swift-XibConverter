//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/7/5.
//

import Foundation

public enum XibConverterError: Error {
    case missingAttribute(String)
    case missingXibInstance
}

public enum XibElementInitError: Error {
    case missingAttribute(String)
    case undefinedKey
    case ignoredElementInited
}

public enum XibConstraintInitError: Error {
    case undefineAttributeKey(String)
}

public enum XibSubViewInitError: Error {
    case initUsingAttributes
    case parentIDNotFound
}
