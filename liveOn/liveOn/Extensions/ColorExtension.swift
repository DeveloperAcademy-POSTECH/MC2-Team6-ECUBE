//
//  ColorExtension.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/05.
//

import SwiftUI

extension Color {
    static let background = Color("background")
    static let bodyTextColor = Color("bodyText")

    static let recordingBtn = Color("Orange")
    static let recordingBtnBackground = Color("Grey")
    static let cassetteBorder = Color("CassetteBorder")
    
    static let primaryColor = Color(hex: "#A5726F")
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }

}
