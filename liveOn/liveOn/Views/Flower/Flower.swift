//
//  Flower.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/08.
//

import Foundation

enum MessageCardColor {
    case white
    case pink
    case yellow
    case green
    case blue
    case purple
}

class Flower: Identifiable, ObservableObject {

    let id: UUID
    
    // 꽃 관련
    let name: String
    let meaning: String
    let lastsfor: Int
    let imageName: String
    // 메시지 관련
    let message: String
    let color: MessageCardColor
    
    init(name: String, message: String, meaning: String, lastsfor: Int, color: MessageCardColor, imageName: String) {
        id = UUID()
        self.name = name
        self.meaning = meaning
        self.lastsfor = lastsfor
        
        self.message = message
        self.color = color
        self.imageName = imageName
    }

}

let flowerList: [Flower] = [
    // Sample data
    Flower(
        name: "리시안셔스",
        message: "피카츄 라이츄 파이리 꼬북이 버터풀 야도란 피죤투 또가스",
        meaning: "변치않는 사랑",
        lastsfor: 2,

        color: MessageCardColor.white,
        imageName: "flower3"
    ),
    Flower(
        name: "금목서",
        message: "서로 생긴 모습은 달라도",
        meaning: "당신의 마음을 끌다",
        lastsfor: 8,

        color: MessageCardColor.white,
        imageName: "flower2"),
    Flower(
        name: "안개꽃",
        message: "우리는 모두 친구(맞아)",
        meaning: "성공",
        lastsfor: 6,

        color: MessageCardColor.white,
        imageName: "flower1"
    )
]
