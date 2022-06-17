//
//  FontNames.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/17.
//

import Foundation
import SwiftUI
struct FontNames {
    static let handWritten = "나눔손글씨 나의 아내 손글씨"
}

extension Text {
    func setHandWritten() -> some View {
        self.font(.custom(FontNames.handWritten, size: 24))
    }
}

extension TextEditor {
    func setHandWritten() -> some View {
        self.font(.custom(FontNames.handWritten, size: 24))
    }
}

extension View {
    func setHandWritten() -> some View {
        self.font(.custom(FontNames.handWritten, size: 24))
    }
}
