//
//  AuthResponseDto.swift
//  liveOn
//
//  Created by Jihye Hong on 2022/06/16.
//

import Foundation

struct LoginResponseDTO: Decodable {
    let accessToken: String
    let isNewMember: Bool
    let refreshToken: String
    let userSettingDone: Bool
    
}
