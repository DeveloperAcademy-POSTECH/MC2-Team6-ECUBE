//
//  SetNicknameView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/08.
//

import SwiftUI

struct SetNicknameView: View {
    @EnvironmentObject var currentUser: User
    @State var nickNameInput: String = ""
    let nickNameLimit = 10
    var body: some View {

            OnboardingHeader(title: "어떤 별명으로 불리나요?", description: "리본에서 사용할 닉네임을 입력해주세요.", inputView:
                                AnyView(
                                    VStack {
                TextField("닉네임 입력 (최대 5자)", text: $nickNameInput)
                    .limitInputLength(value: $nickNameInput, length: nickNameLimit)
                    .multilineTextAlignment(.center)
                Text("\(nickNameInput.count)/10")
                    .opacity(0.5)
                Spacer()
            } .padding(.top, 50))
            )
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                                NavigationLink(destination: SetBirthdayView().environmentObject(currentUser)) {
                    Text("다음")
                }
                .buttonStyle(.plain)
                .disabled(nickNameInput.isEmpty ? true : false )
                
                // MARK: User 데이터 저장
                .simultaneousGesture(TapGesture().onEnded {
                    currentUser.nickname = nickNameInput
                })
            }
        } // toolbar
        .navigationBarBackButtonHidden(true)
    } // body
}

struct SetNicknameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SetNicknameView()
                .environmentObject(User())
        }
    }
}

enum InputStyle {
    case StringInput
    case DateInput
}

struct OnboardingHeader: View {
    let title: String
    let description: String
    let inputView: AnyView?
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text(description)
                .multilineTextAlignment(.center)
            inputView
        }
        .foregroundColor(.bodyTextColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        
    }
}
