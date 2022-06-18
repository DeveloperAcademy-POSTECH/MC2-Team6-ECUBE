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
    @Published var birth: Date = Date()
    @Published var firstDay: Date = Date()
    @Published var userCode: String = "UTest"
}
