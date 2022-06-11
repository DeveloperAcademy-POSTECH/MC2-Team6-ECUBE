//
//  SignInWithAppleViewModel.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/09.
//

import AuthenticationServices

class SignInWithAppleViewModel: NSObject, ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            case let appleIdCredential as ASAuthorizationAppleIDCredential:
                print("\n ** ASAuthorizationAppleIDCredential - \(#function)** \n")
                print(appleIdCredential.email ?? "Email not available.")
                print(appleIdCredential.fullName ?? "fullname not available")
                print(appleIdCredential.fullName?.givenName ?? "givenName not available")
                print(appleIdCredential.fullName?.familyName ?? "Familyname not available")
                print(appleIdCredential.user)  // This is a user identifier
                print(appleIdCredential.identityToken?.base64EncodedString() ?? "Identity token not available") // JWT Token
                print(appleIdCredential.authorizationCode?.base64EncodedString() ?? "Authorization code not available")
                break
            case let passwordCredential as ASPasswordCredential:
                print("\n ** ASPasswordCredential ** \n")
                print(passwordCredential.user)  // This is a user identifier
                print(passwordCredential.password) // The password
                break
                
            default:
                break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("\n -- ASAuthorizationControllerDelegate -\(#function) -- \n")
        print(error)
    }
}

extension SignInWithAppleViewModel {
  private func registerNewUser(credential: ASAuthorizationAppleIDCredential) {
    // API Call - Pass the email, user full name, user identity provided by Apple and other details.
    // Give Call Back to UI
  }
  
  private func signInExistingUser(credential: ASAuthorizationAppleIDCredential) {
    // API Call - Pass the user identity, authorizationCode and identity token
    // Give Call Back to UI
  }
  
  private func signinWithUserNamePassword(credential: ASPasswordCredential) {
    // API Call - Sign in with Username and password
    // Give Call Back to UI
  }
}
