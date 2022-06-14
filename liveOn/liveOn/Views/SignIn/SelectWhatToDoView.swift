//
//  SelectWhatToDoView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/08.
//

import SwiftUI

struct SelectWhatToDoView: View {
    @EnvironmentObject var currentUser: User
    @State var showEnterCodeSheet: Bool = false
    var body: some View {
        OnboardingHeader(title: " 상대를 초대해주세요! ", description: "상대가 앱을 설치하고 초대코드를 입력하면  매칭해드릴게요.", inputView:
                            AnyView(
                                VStack {
                                    Text("\(currentUser.userCode)")
                                        .font(.title)
                                        .fontWeight(.heavy)
                                        .padding(.top, 50)
                                    Spacer()
                                    // TODO: 액티비티 시트 연결(공유)
                                    Button {}
                                label: {
                                    HStack {
                                        Image(systemName: "envelope.fill")
                                        Text("초대코드 보내기")
                                            .font(.title3)
                                    }
                                    .foregroundColor(Color(uiColor: .label))
                                    .colorInvert()
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: 64)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.primaryColor))
                                    .padding()
                                }// Button
                                .buttonStyle(.plain)
                                    NavigationLink(destination: EnterCode()) {
                                        Text("이미 초대코드가 있어요")
                                            .fontWeight(.bold)
                                            .padding()
                                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.bodyTextColor).opacity(0.1))
                                    }// nav link
                                })
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: GiftBoxView()
                    .navigationBarHidden(true)
                    .environmentObject(currentUser)) {
                    Text("다음")
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct SelectWhatToDoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SelectWhatToDoView()
                .environmentObject(User())
        }
    }
}

struct EnterCode: View {
    // TODO: 다시해야함.
    @State var code: String = ""
    var body: some View {
        
        OnboardingHeader(title: "5자리 초대코드를 입력해주세요!", description: "먼저 리본에 가입한 상대에게 받은 초대코드를 입력해주세요", inputView: AnyView(
            VStack {
                TextField("5자리 코드 입력", text: $code)
                    .font(.title)
                    .limitInputLength(value: $code, length: 5)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: EmptyView()) {
                            Text("다음")
                        }
                        .buttonStyle(.plain)
                    }
                }
        ))
        
    }
    
    func isCorrect(userCode: String) -> Bool {
        return self.code == userCode
    }
}
