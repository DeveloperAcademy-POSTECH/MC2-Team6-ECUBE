//
//  SelectWhatToDoView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/08.
//

import SwiftUI

struct SelectWhatToDoView: View {
    @EnvironmentObject var currentUser: User
    @Environment(\.dismiss) private var dismiss
    @State var showEnterCodeSheet: Bool = false
    
    var copyButton: some View {
        ZStack(alignment: .top) {
            Image(systemName: "arrowtriangle.up.fill")
                .foregroundColor(.accentColor)
                .offset(y: 1)
            Text("복사하기")
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 18)
                .background( RoundedRectangle(cornerRadius: 4)
                    .fill(Color.accentColor)
                )
                .padding(.top, 10)
            
        }
    }
    
    var body: some View {
        OnboardingHeader(title: "상대방 초대하기! ", description: "상대가 앱을 설치하고 초대코드를 입력하면 서로를 이어드릴게요.", inputView:
                            AnyView(
                                VStack {
                                    VStack {
                                        Text("\(currentUser.userCode)")
                                            .font(.title)
                                            .fontWeight(.heavy)
                                            .frame(width: 268, height: 170, alignment: .center)
                                            .background(RoundedRectangle(cornerRadius: 20).fill(Color(uiColor: .systemBackground)).shadow(color: .bodyTextColor.opacity(0.3), radius: 6, x: 0, y: 2))
                                            .padding(.top, 40)
                                        copyButton
                                        
                                    }
                                    Spacer()
                                    // TODO: 액티비티 시트 연결(공유)
                                    
                                    NavigationLink(destination: EnterCode()) {
                                        Text("이미 초대코드가 있어요")
                                            .fontWeight(.bold)
                                            .padding()
                                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.bodyTextColor).opacity(0.1))
                                    }// nav link
                                }.frame(maxWidth: .infinity))
                         
        )
        .background(Color.background)
        .navigationToBack(dismiss)
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
                    .padding(16)
                Spacer()
            }
        ))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: EmptyView()) {
                    Text("다음")
                }
                .buttonStyle(.plain)
            }
        }
        
    }
    
    func isCorrect(userCode: String) -> Bool {
        return self.code == userCode
    }
}
