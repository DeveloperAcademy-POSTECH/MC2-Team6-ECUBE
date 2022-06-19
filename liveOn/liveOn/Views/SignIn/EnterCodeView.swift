//
//  EnterCodeView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/18.
//

import SwiftUI

struct EnterCodeView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var currentUser: User
    @State var code: String = ""
    @State var checkCode: Bool = false
    @State var presentFailAlert: Bool = false
    var body: some View {
        NavigationView {
                
//                OnboardingHeader(title: "5자리 초대코드를 입력해주세요!", description: "먼저 리본에 가입한 상대에게 받은 초대코드를 입력해주세요", inputView: AnyView(
            VStack(alignment: .center, spacing: 12) {
                VStack {
                    VStack(alignment: .leading, spacing: 12) {
                    Text("5자리 초대코드를 \n입력해주세요!")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Text("먼저 리본에 가입한 상대방에게 받은 초대코드를 입력해주세요")
                        .multilineTextAlignment(.leading)
                        .truncationMode(.head)
                      
                    }
                    .foregroundColor(.bodyTextColor)
                   
                    .padding(24)
                    TextField("5자리 코드 입력", text: $code)
                                        .font(.title)
                                        .limitInputLength(value: $code, length: 5)
                                        .multilineTextAlignment(.center)
                                        .padding(16)
                        
            }
                 
                Spacer()
                // MARK: 코드 확인
                Button {
                    // MARK: 조건 체크 임시 비활성화
//                    if code == currentUser.userCode && code.count == 5 {
//                        checkCode.toggle()
//                    }
//                    else {
//                        presentFailAlert.toggle()
//                    }
                    checkCode.toggle()
                }
            label: {
                Text("초대코드 확인")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: 358, maxHeight: 60, alignment: .center).background(RoundedRectangle(cornerRadius: 10).fill(Color.accentColor))
            }
            .alert(isPresented: $presentFailAlert) {
                Alert(title: Text("매칭 실패"), message: Text("초대코드를 다시 확인해주세요"), dismissButton: .default(Text("확인"))
                )}
                
                NavigationLink("", destination: WelcomMatchingView().environmentObject(currentUser), isActive: $checkCode)
                
            }
            .background(Color.background)
            .navigationCancel(dismiss)
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    func isCorrect(userCode: String) -> Bool {
        return self.code == userCode
    }
}

struct EnterCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterCodeView()
            .environmentObject(User())
    }
}
