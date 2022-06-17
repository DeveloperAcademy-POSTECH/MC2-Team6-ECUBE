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
    let letterStyle: String
    init(content: String, createdDate: Date, writer: String) {
        id = UUID()
        self.content = content
        self.writer = writer
        self.createdDate = DateToString(createdDate)
        self.letterStyle = getRandomLetterStyle()
        
    }
}

class LetterStore: ObservableObject {
    @Published var list: [Letter]
    
    init() {
        list = [
            Letter(content: "재헌아 오늘은 날씨가 좀 춥다! 얼마안남았지만 힘내", createdDate: Date.now, writer: "유진"),
            Letter(content: "보고싶은 맘은 크지만.. 우리 서로 이시간을 잘 보내자", createdDate: Date.distantPast, writer: "재헌"),
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
