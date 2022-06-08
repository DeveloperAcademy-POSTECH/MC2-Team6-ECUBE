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
        NavigationView {
            VStack {
                Text("liveOn")
                Spacer()
                SignInWithApple()
                  .frame( height: 60)
                  .padding()
                NavigationLink(destination: SetNicknameView().environmentObject(User())) {
                    Text("임시 다음 버튼")
                }
            }
        }
    }
}


struct GettingStart_Previews: PreviewProvider {
    static var previews: some View {
        GettingStartView()
    }
}

// 1
final class SignInWithApple: UIViewRepresentable {
  // 2
  func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
    // 3
    return ASAuthorizationAppleIDButton()
  }
  
  // 4
  func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
  }
}
