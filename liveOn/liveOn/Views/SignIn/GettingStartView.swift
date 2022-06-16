//
//  GettingStart.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/08.
//

import SwiftUI
import AuthenticationServices

struct GettingStartView: View {
    var body: some View {
            VStack {
                Text("liveOn")
                Spacer()
//                QuickSignInWithApple()
                    .frame(height: 60, alignment: .center)
//                    .onTapGesture(perform: showAppleLoginView)
//
                    .onTapGesture {
                        print("임시 다음 버튼 누르셈")
                    }
                  .padding()
                NavigationLink(destination: SetNicknameView().environmentObject(User())) {
                    Text("임시 다음 버튼")
                }
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

struct GettingStart_Previews: PreviewProvider {
    static var previews: some View {
        GettingStartView()
    }
}
