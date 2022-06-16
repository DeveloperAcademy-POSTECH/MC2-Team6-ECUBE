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
    
    func uploadVM(title: String) {
        
        authProvider.request(.voicemailPost(title: title)) { response in
            
            switch response {
            case .success(let result):
                print(result)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getVM() {
        authProvider.request(.voicemailListGet) { response in
            
            switch response {
            case .success(let result):
//                print("result: \(result)")₩
                do {
                    print("result: \(result)")
//                    self.vmList = try result.map([VoicemailListGetResponse].self)

                } catch let err {
                    print(err.localizedDescription)
                }
                
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
