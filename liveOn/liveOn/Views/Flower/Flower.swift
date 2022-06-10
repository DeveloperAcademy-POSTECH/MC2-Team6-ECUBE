//
//  Flower.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/08.
//

import Foundation

class Flower: Identifiable, ObservableObject {

    let id: UUID

    let name: String
    let color: String
    let meaning: String
    let lastsfor: Int
    
    init(name: String, color: String, meaning: String, lastsfor: Int) {
        id = UUID()
        self.name = name
        self.color = color
        self.meaning = meaning
        self.lastsfor = lastsfor
    }
}

let flowerList: [Flower] = [
    // Sample data
    Flower(
        name: "리시안셔스",
        color: "붉은색",
        meaning: "변치않는 사랑",
        lastsfor: 2),
    Flower(
        name: "금목서",
        color: "붉은색",
        meaning: "당신의 마음을 끌다",
        lastsfor: 8),
    Flower(
        name: "안개꽃",
        color: "노란색",
        meaning: "성공",
        lastsfor: 6)
]
