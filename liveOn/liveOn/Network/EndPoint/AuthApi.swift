//
//  AuthApi.swift
//  liveOn
//
//  Created by Jihye Hong on 2022/06/16.
//

import Foundation
import Moya

enum AuthAPI {
    case login(request: LoginRequestDTO)
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: API.baseURL)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "api/v1/auth/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(let loginRequestDTO):
            return .requestJSONEncodable(loginRequestDTO)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
