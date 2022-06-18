//
//  GettingStart.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/08.
//

import SwiftUI
import Moya
import AuthenticationServices

struct GettingStartView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel = AuthenticationViewModel()
    @State private var authenticationData: String = ""
    @State private var isActive: Bool = false
    
    let authProvider = MoyaProvider<AuthAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8){
            
            Group {
                Image("TestApp")
                    .frame(width: 61, height: 61)
                
                Text("하루에 하나씩,")
                    .mainTextStyle()
                
                Text("기념일을 기념하기")
                    .mainTextStyle()
                
                Text("live'On")
                    .foregroundColor(.mainBrown)
                    .font(.system(size: 36))
                    .fontWeight(.heavy)
            }
            .padding(.leading, 20)
            
            Spacer()
            
                .frame(height: 60, alignment: .center)
            
            Button(action: {
                print(authenticationData)
            }){
                Text("Data확인")
            }
            
            Button("시뮬레이터용 임시 다음버튼") {
                isActive.toggle()
            }
            
            
            NavigationLink(destination: SetNicknameView().environmentObject(User()), isActive: $isActive) {
                Text("")
            }
            .padding(.bottom, 40)
            
            SignInWithAppleButton(.signIn, onRequest: { request in request.requestedScopes = []
            }, onCompletion: { result in
                authenticationData = authenticationViewModel.didFinishAuthentication(result: result)
                isActive.toggle()
            })
            .frame(height: 45)
            .padding()
        }
    }
    
    // didfinishAUthenticairton에 result를 넣으면, appleUser.identityToken을 산출해주고
    // applUser.identityToken을 authNetwrokService의 login 함수에 넣으면 디코딩된 결과를 반환해준다. 
    
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
        GettingStartView(authenticationViewModel: AuthenticationViewModel())
    }
}
