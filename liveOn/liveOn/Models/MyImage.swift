//
//  MyImage.swift
//  liveOn
//
//  Created by Jisu Jang on 2022/06/06.
//

import Foundation

// 이미지 데이터 저장양식?
struct MyImage: Identifiable, Codable {
    var id = UUID()
    var name: String
}
