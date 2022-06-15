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
    let prescribedDate: String
    let sender: String
    
    init(name: String, color: String, effect: String, prescribedDate: String, sender: String) {
        
        id = UUID()
        self.name = name
        self.color = color
        self.effect = effect
        self.prescribedDate = prescribedDate
        self.sender = sender
        
    }
}

// Sample data
let pillList: [Pill] = [
    
    Pill(
        name: "박카스",
        color: "갈색",
        effect: "박카스 한 병과 함께 솟아나는 호랑이 기운!",
        prescribedDate: "220614",
        sender: "유진"),
    Pill(
        name: "쏠라C",
        color: "노란색",
        effect: "시큼하고 달달한 맛에 기운이 솟아납니다.",
        prescribedDate: "220614",
        sender: "재헌"),
    Pill(
        name: "텐텐",
        color: "붉은색",
        effect: "추억이 되살아납니다.",
        prescribedDate: "220614",
        sender: "유진"),
    Pill(
        name: "마그네슘",
        color: "흰색",
        effect: "눈 밑 떨림을 해소합니다.",
        prescribedDate: "220614",
        sender: "재헌"),
    Pill(
        name: "박카스",
        color: "갈색",
        effect: "박카스 한 병과 함께 솟아나는 호랑이 기운!",
        prescribedDate: "220614",
        sender: "재헌"),
    Pill(
        name: "쏠라C",
        color: "노란색",
        effect: "시큼하고 달달한 맛에 기운이 솟아납니다.",
        prescribedDate: "220614",
        sender: "재헌"),
    Pill(
        name: "텐텐",
        color: "붉은색",
        effect: "추억이 되살아납니다.",
        prescribedDate: "220614",
        sender: "재헌"),
    Pill(
        name: "마그네슘",
        color: "흰색",
        effect: "눈 밑 떨림을 해소합니다.",
        prescribedDate: "220614",
        sender: "재헌"),
    Pill(
        name: "박카스",
        color: "갈색",
        effect: "박카스 한 병과 함께 솟아나는 호랑이 기운!",
        prescribedDate: "220614",
        sender: "재헌"),
    Pill(
        name: "쏠라C",
        color: "노란색",
        effect: "시큼하고 달달한 맛에 기운이 솟아납니다.",
        prescribedDate: "220614",
        sender: "재헌"),
    Pill(
        name: "텐텐",
        color: "붉은색",
        effect: "추억이 되살아납니다.",
        prescribedDate: "220614",
        sender: "유진"),
    Pill(
        name: "마그네슘",
        color: "흰색",
        effect: "눈 밑 떨림을 해소합니다.",
        prescribedDate: "220614",
        sender: "유진"),
    Pill(
        name: "박카스",
        color: "갈색",
        effect: "박카스 한 병과 함께 솟아나는 호랑이 기운!",
        prescribedDate: "220614",
        sender: "유진"),
    Pill(
        name: "쏠라C",
        color: "노란색",
        effect: "시큼하고 달달한 맛에 기운이 솟아납니다.",
        prescribedDate: "220614",
        sender: "유진"),
    Pill(
        name: "텐텐",
        color: "붉은색",
        effect: "추억이 되살아납니다.",
        prescribedDate: "220614",
        sender: "유진"),
    Pill(
        name: "마그네슘",
        color: "흰색",
        effect: "눈 밑 떨림을 해소합니다.",
        prescribedDate: "220614",
        sender: "유진"),
    Pill(
        name: "진통제",
        color: "빨간색",
        effect: "통증을 가라앉힙니다.",
        prescribedDate: "220614",
        sender: "재헌")
]
