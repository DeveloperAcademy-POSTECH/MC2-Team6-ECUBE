//
//  Recording.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/07.
//

import Foundation

struct Recording: Equatable {
    
    let fileURL: URL
    let createdAt: Date
    let title: String
    let duration: String
    var isPlaying: Bool
    
}
