//
//  Recording.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/07.
//

import Foundation

struct Recording: Equatable {
    
    var fileURL: URL
    let createdAt: Date
    var isPlaying: Bool
    var title: String
    
}
