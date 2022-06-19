//
//  TextExtension.swift
//  liveOn
//
//  Created by Jisu Jang on 2022/06/17.
//

import SwiftUI

extension Text {
    func mainTextStyle() -> some View {
        foregroundColor(.mainBrown)
            .font(.system(size: 20))
            .fontWeight(.regular)
    }
}
