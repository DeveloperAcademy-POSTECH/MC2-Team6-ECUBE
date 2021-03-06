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
    static let placeHolderColor = Color(hex: "D9D9D9")
    static let crimson = Color(hex: "902F2F")
    static let mainBrown = Color(hex: "6C5151")
    static let lightGray = Color(hex: "EFEFEF")

    static let recordingBtn = Color("Orange")
    static let recordingBtnBackground = Color("Grey")
    static let cassetteBorder = Color("CassetteBorder")
    static let deepGreen = Color(hex: "2F8F4A")
    static let coralPink = Color(hex: "DB5E5E")
    static let shadowColor = Color(hex: "F2F0F0")
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
