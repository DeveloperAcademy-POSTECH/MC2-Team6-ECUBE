//
//  QuickSignInWithApple.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/09.
//

import SwiftUI
import AuthenticationServices

struct QuickSignInWithApple: UIViewRepresentable {
    typealias UIViewType = ASAuthorizationAppleIDButton
   
    func makeUIView(context: Self.Context) -> Self.UIViewType {
        return ASAuthorizationAppleIDButton()
    }
    
    func updateUIView(_ uiView: Self.UIViewType, context: Context) {
    }
}

struct QuickSignInWithApple_Previews: PreviewProvider {
    static var previews: some View {
        QuickSignInWithApple()
    }
}
