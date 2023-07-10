//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/7/10.
//

import Foundation
import ArgumentParser
import XibConverter

@main
struct Xib: ParsableCommand {
    
    @Argument(help: "input file path", completion: .file(extensions: [".xib"]))
    var inputFile: String

    @Option(name: .customShort("o", allowingJoined: false), help: "output file path")
    var outputFile: String?
    
    @Option(name: [.customShort("c", allowingJoined: false), .customLong("class")], help: "custom class name")
    var customClass: String?
    
    @Option(name: [.customShort("s", allowingJoined: false), .customLong("super")], help: "custom super class name")
    var superClass: String?

    mutating func run() throws {
       guard let data = FileManager.default.contents(atPath: inputFile) else {
            print("file doesn't exist")
            return
        }
        
        let code = xib2Swift(xibData: data, className: customClass, superclass: superClass)
        
        if let outputFile {
            try code.write(toFile: outputFile, atomically: true, encoding: .utf8)
        }else {
            print(code)
        }
        
    }
}

