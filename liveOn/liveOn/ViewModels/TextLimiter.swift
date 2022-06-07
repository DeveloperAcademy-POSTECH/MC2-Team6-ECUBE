//
//  TextLimiter.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/06.
//

import Foundation
import SwiftUI

class TextLimiter: ObservableObject {
    let limit: Int
    let placeholder: String
    init(limit: Int, placeholder: String) {
        self.limit = limit
        self.placeholder = placeholder
        value = placeholder
    }
    
    @Published var value = "" {
        didSet {
            // 사용자가 입력했는지 체크
            if value.count > 0 &&  value != placeholder {
                self.inputEntered = true }
            else {
                self.inputEntered = false
            }
            
            // 제한글자를 넘어서면 더 이상 쳐지지 않게 하기
            if value.count > self.limit {
                value = String(value.prefix(self.limit))
                self.hasReachedLimit = true
            } else {
                self.hasReachedLimit = false
            }
        }
    }
    @Published var hasReachedLimit = false
    @Published var inputEntered = false
}
