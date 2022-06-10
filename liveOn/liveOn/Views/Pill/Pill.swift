//
//  Pill.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/08.
//

import Foundation

class Pill: Identifiable, ObservableObject {

    let id: UUID

    let name: String
    let color: String
    let effect: String
    
    init(name: String, color: String, effect: String) {
        
        id = UUID()
        self.name = name
        self.color = color
        self.effect = effect
        
    }
}

// Sample data
let piilList: [Pill] = [
    
    Pill(
        name: "비타민 C",
        color: "붉은색",
        effect: "시큼합니다"),
    Pill(
        name: "마그네슘",
        color: "흰색",
        effect: "눈 밑 떨림을 해소합니다"),
    Pill(
        name: "진통제",
        color: "노란색",
        effect: "통증을 가라앉힙니다")
    
]
