//
//  GettingStart.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/08.
//

import SwiftUI
import AuthenticationServices

struct GettingStartView: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel = AuthenticationViewModel()
    
    var body: some View {
            VStack {
                
                Image("TransportSucceed")
                
                Spacer()
                    .frame(height: 60, alignment: .center)
                    .onTapGesture {
                        print("임시 다음 버튼 누르셈")
                    }
                  .padding()
                
                NavigationLink(destination: SetNicknameView().environmentObject(User())) {
                    Text("임시 다음 버튼")
                }.onTapGesture {
                    print("임시 다음 버튼 누르셈")
                }
                .padding(.bottom, 40)
                
                SignInWithAppleButton(.signIn, onRequest: {request in request.requestedScopes = []}, onCompletion: {result in authenticationViewModel.didFinishAuthentication(result: result)}
                )
                .frame(height: 45)
                .padding()
            }
    }
    
    private func showAppleLoginView() {

            let provider = ASAuthorizationAppleIDProvider()

            let request = provider.createRequest()

            request.requestedScopes = [.fullName, .email]

            let controller = ASAuthorizationController(authorizationRequests: [request])
        
            controller.performRequests()
        
    }
}

// struct GettingStart_Previews: PreviewProvider {
//    static var previews: some View {
//        GettingStartView(authenticationViewModel: authenticationViewModel)
//    }
// }
