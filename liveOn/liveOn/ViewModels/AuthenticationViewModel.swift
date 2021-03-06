//
//  GettingStartedViewModel.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/16.
//

import Foundation
import AuthenticationServices

class AuthenticationViewModel: ObservableObject {
    private let authNetworkService = AuthNetworkService()
//    @ObservedObject var authNetworkService: AuthNetworkService = AuthNetworkService()
    
//    @Published var shouldShowAlert: Bool = false
//    @Published var alertTitle: String = ""
//    @Published var alertMessage: String = ""
//
//    //get notified when autherization state gets change
//    init() {
//        NotificationCenter.default.addObserver(self, selector: #selector(getAuthorizationState), name: ASAuthorizationAppleIDProvider.credentialRevokedNotification, object: nil)
//    }
    func didFinishAuthentication(result: Result<ASAuthorization, Error>) -> String {
        var tokenData = ""
    
        print("didFinishAuthentication")
        switch result {
        case.success(let auth):
                switch auth.credential {
                    case let appleIdCredentials as ASAuthorizationAppleIDCredential:
                        if let appleUser = AppleUser(credentials: appleIdCredentials),
                           let appleUserData = try? JSONEncoder().encode(appleUser) {
                            UserDefaults.standard.setValue(appleUserData, forKey: appleUser.userId)
                            
                            let idToken = appleIdCredentials.identityToken!
                            let tokenStr = String(data: idToken, encoding: .ascii)
                            
                            print(tokenStr ?? "")
                            print("saved apple user")
                
                        } else {
                            print("missing some fields")
                        }
                        guard
                            let appleUserData = UserDefaults.standard.data(forKey: appleIdCredentials.user),
                            let appleUser = try? JSONDecoder().decode(AppleUser.self, from: appleUserData)
        
                        else {return ""}
                    print("AppleUser ???????????????.")
                    print(appleUser)
                    print("Apple user??? identityToken??? ???????????????.")
                    print(appleUser.identityToken)
                    
                    // ??????????????? ????????? ??????????????????
                    // ??? ?????? ????????? ?????? ?????? ?????? ??? ????????? ?????? ??????
                    tokenData = authNetworkService.login(accessToken: appleUser.identityToken)
                    
                    default:
                        print(auth.credential)
                }
                return ""
            case .failure(let error):
                print(error)
        }
        return tokenData
    }
    
//    @objc func getAuthorizationState() {
//            let provider = ASAuthorizationAppleIDProvider()
//            if let userId = UserDefaults.standard.value(forKey: "userId") as? String {
//                provider.getCredentialState(forUserID: userId) { [self] (state, error) in
//                    switch state {
//                    case .authorized:
//                        // Credential are still valid
//                        break
//                    case .revoked:
//                        //Credential is revoked. It is similar to Logout. Show login screen.
//                        self.deleteUserData()
//                        break
//                    case .notFound:
//                        //Credential was not found. Show login screen.
//                        self.deleteUserData()
//                        break
//                    case .transferred:
//                        //The app is transfeered from one development team to another development team. You need to login again so show login screen.
//                        self.deleteUserData()
//                        break
//                    default:
//                        break
//                    }
//                }
//            }
//    }
}
