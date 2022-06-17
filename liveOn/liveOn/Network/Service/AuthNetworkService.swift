//
//  AuthNetworkService.swift
//  liveOn
//
//  Created by Jihye Hong on 2022/06/16.
//

import Foundation
import Moya
import UIKit



class AuthNetworkService {
    
//    private let authPlugin = AccessTokenPlugin { _ in API.token }
    
    let authProvider = MoyaProvider<AuthAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func login(accessToken: String) -> String {
        var tokenResponse = LoginResponseDTO(accessToken: "", isNewMember: false, refreshToken: "", userSettingDone: false)
        
        let param = LoginRequestDTO.init(accessToken: accessToken)
        
        authProvider.request(.login(request: param)) { response in
            switch response {
            case .success(let result):
                print(result)
                
                tokenResponse = try! result.map(LoginResponseDTO.self)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
        return tokenResponse.accessToken
    }
}
