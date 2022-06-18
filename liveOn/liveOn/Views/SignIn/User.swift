//
//  User.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/08.
//

import SwiftUI

class User: Identifiable, ObservableObject {
    let id = UUID()
    @Published var nickname: String  = ""
    @Published var birth: Date?
    @Published var firstDay: Date?
    @Published var userCode: String = "111111"
    init() {
        userCode = randomString(length: 5)
    }
}

func randomString(length: Int) -> String {

    let letters : NSString = "abcdefghijklmnopqrstuvwxyz0123456789"
    let len = UInt32(letters.length)

    var randomString = ""

    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }

    return randomString
}
