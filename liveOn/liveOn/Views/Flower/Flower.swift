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
        name: "프리지아",
        message: "재헌이의 인턴을 기념하며!",
        meaning: "새로운 시작을 응원합니다",
        lastsfor: 6,

        color: MessageCardColor.white,
        imageName: "flower01"
    ),
    Flower(
        name: "금목서",
        message: "처음 너를 봤을 때",
        meaning: "당신의 마음을 끌다",
        lastsfor: 8,

        color: MessageCardColor.white,
        imageName: "flower02"),
   
    Flower(
        name: "노란 안개꽃",
        message: "재헌! 아직 우린 새벽이야",
        meaning: "너의 성공을 위하여!",
        lastsfor: 6,

        color: MessageCardColor.white,
        imageName: "flower03"
    ),
    Flower(
        name: "리시안셔스",
        message: "내가 표현 잘 못하는거 알지? 마음만은 항상 진심이야",
        meaning: "변치않는 사랑",
        lastsfor: 2,

        color: MessageCardColor.white,
        imageName: "flower04"
    )

]
