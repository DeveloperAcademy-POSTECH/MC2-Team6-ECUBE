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
    private let limit: Int = 6
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            OnboardingHeader(title: "별명 정하기", description: "주고 받은 선물에 별명이 표시돼요.", inputView:
                                AnyView(
                                    VStack {
                                        HStack {
                                            TextField("닉네임 입력 (최대 \(limit)자)", text: $nickNameInput)
                                                .limitInputLength(value: $nickNameInput, length: limit)
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                            Text("\(nickNameInput.count)/\(self.limit)")
                                                .opacity(0.5)
                                                .foregroundColor(nickNameInput.count < limit ? Color.bodyTextColor : Color.primaryColor)
                                        }
                                        Rectangle()
                                                .fill(nickNameInput.count < limit ? Color.bodyTextColor : Color.primaryColor)
                                                .frame(maxWidth: .infinity, maxHeight: 2, alignment: .bottom)
                                    })) // VStack

        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.background)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SetBirthdayView()
                    .environmentObject(currentUser)) {
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
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            Text(description)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 64)
            inputView
            Spacer()
        }
        .foregroundColor(.bodyTextColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(24)
        
    }
}
