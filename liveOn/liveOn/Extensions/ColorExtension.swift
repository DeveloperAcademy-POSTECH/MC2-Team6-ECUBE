//
//  ColorExtension.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/05.
//

import SwiftUI

// 헥사 코드 컬러 rgb 변환
extension Color {
    static let backGround = Color(hex: "#FDFBFB")
    static let bodyTextColor = Color(hex: "564D4D")
    static let primaryColor = Color(hex: "#A5726F")
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        let _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
