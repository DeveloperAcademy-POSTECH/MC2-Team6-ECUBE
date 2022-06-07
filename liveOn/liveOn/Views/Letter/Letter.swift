//
//  Letter.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/06.
//

import Foundation
import SwiftUI
class Letter: Identifiable, ObservableObject {
    let id: UUID
    @Published var content: String
    let createdDate: String
    let writer: String
    
    init(content: String, createdDate: Date, writer: String) {
        id = UUID()
        self.content = content
        self.writer = writer
        self.createdDate = DateToString(createdDate)
        
    }
}

class LetterStore: ObservableObject {
    @Published var list: [Letter]
    
    init() {
        list = [
            Letter(content: "재허나 뭐해앵", createdDate: Date.now, writer: "유진"),
            Letter(content: "유지나 뭐해앵", createdDate: Date.distantPast, writer: "재헌"),
            Letter(content: "재허나 뭐해앵", createdDate: Date.distantPast, writer: "유진")
            
        ]
    }
    
    func insert(letter: String, writer: String) {
        list.insert(Letter(content: letter, createdDate: Date.now, writer: writer), at: 0)
    }
    
    func update(letter: Letter?, content: String) {
        guard let letter = letter else {
            return
        }
        letter.content = content
    }
}
