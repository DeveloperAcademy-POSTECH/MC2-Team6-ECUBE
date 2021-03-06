//
//  ServerCommunicationVM.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/14.
//

import Moya
import UIKit

class ServerCommunication {
    
//    var vmList: [VoicemailListGetResponse] = []
    
    private let authPlugin = AccessTokenPlugin { _ in GeneralAPI.token }
    
    private lazy var authProvider = MoyaProvider<ServerCommunications>(plugins: [authPlugin, NetworkLoggerPlugin(verbose: true)])
    
    func login(userName: String) {
        let param = LoginRequest.init(name: userName)
        
        authProvider.request(.login(param: param)) { response in
            switch response {
            case .success(let result):
                print(result)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func uploadImage(fileName: String, image: UIImage) {
        
        authProvider.request(.imagePost(comment: fileName, polaroid: image)) { response in
            
            switch response {
            case .success:
                print("response: \(response)")
//                print(response.)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func uploadVM(title: String, name: String, duration: String) {
        
        authProvider.request(.voicemailPost(title: title, name: name, duration: duration)) { response in
            
            switch response {
            case .success(let result):
                print(result)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getData() {
        
        authProvider.request(.getData) { response in
            
            switch response {
            case .success(let result):
                print(result)
                
            case .failure(let err):
                print(err)
            }
        }
    }
}
