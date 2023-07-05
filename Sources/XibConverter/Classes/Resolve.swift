//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/7/4.
//

import Foundation


class Resolve {
    static func color(node: XibNode) -> String {
        var declaration = ""
        if node.attrs["customColorSpace"] == "genericGamma22GrayColorSpace" || node.attrs["colorSpace"] == "genericGamma22GrayColorSpace" {
            declaration = "UIColor(cgColor: CGColor(genericGrayGamma2_2Gray: \(node.attrs["white"]!), alpha: \(node.attrs["alpha"]!)))"
        }
        else if node.attrs["customColorSpace"] == "sRGB" || node.attrs["colorSpace"] == "sRGB" {
            declaration = "UIColor(cgColor: CGColor(srgbRed: \(node.attrs["red"]!), green: \(node.attrs["green"]!), blue: \(node.attrs["blue"]!), alpha: \(node.attrs["alpha"]!)))"
        }
        else if node.attrs["customColorSpace"] == "displayP3" || node.attrs["colorSpace"] == "displayP3" {
            declaration = "UIColor(displayP3Red: \(node.attrs["red"]!), green: \(node.attrs["green"]!), blue: \(node.attrs["blue"]!), alpha: \(node.attrs["alpha"]!))"
        }
        else if node.attrs["customColorSpace"] == "calibratedWhite" || node.attrs["colorSpace"] == "calibratedWhite" {
            declaration = "UIColor(white: \(node.attrs["white"]!), alpha: \(node.attrs["alpha"]!))"
        }
        else if node.attrs["customColorSpace"] == "calibratedRGB" || node.attrs["colorSpace"] == "calibratedRGB" {
            declaration = "UIColor(red: \(node.attrs["red"]!), green: \(node.attrs["green"]!), blue: \(node.attrs["blue"]!), alpha: \(node.attrs["alpha"]!))"
        }
        else if let systemColor = node.attrs["systemColor"] {
            declaration = ".\(systemColor.replacingOccurrences(of: "Color", with: ""))"
        }
        else if let name = node.attrs["name"] {
            declaration = "UIColor(named: \"\(name)\")"
        }
        
        return declaration
    }
    
    static func image(node: XibNode) -> String? {
        var declaration: String?
        
        if let backgroundImage = node.attrs["backgroundImage"] {
            if node.attrs["catalog"] == "system" {
                declaration = "UIImage(systemName: \"\(backgroundImage)\")"
            } else {
                declaration = "UIImage(named: \"\(backgroundImage)\")"
            }
        }
        else if node.attrs["catalog"] == "system" {
            declaration = "UIImage(systemName: \"\(node.attrs["image"]!)\")"
        }
        else if let name = node.attrs["name"] {
            declaration = "UIImage(named: \"\(name)\")"
        }
        else if let image = node.attrs["image"] {
            declaration = "UIImage(named: \"\(image)\")"
        }
        
        return declaration
    }
}
