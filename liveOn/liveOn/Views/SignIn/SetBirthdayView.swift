//
//  SetBirthdayView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/08.
//

import SwiftUI


struct SetBirthdayView: View {
    @EnvironmentObject var currentUser: User
    @State var birthday: Date = Date.now
    init() {
        
    }
    var body: some View {
        VStack(spacing: 12) {
            OnboardingHeader(title: "생일을 알려주세요 :)", description: "기념일로 등록해둘게요!", inputView:
                                AnyView(  VStack {
                DatePicker("생일 선택", selection: $birthday, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .background(.clear)
                    .applyTextColor(.bodyTextColor)
                    .padding()
                  
            })
            )
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: Text("다음")) {
                    Text("다음")
                }
                .buttonStyle(.plain)
//                .disabled(nickNameInput.isEmpty ? true : false )
                .onTapGesture {
                    currentUser.birth = birthday
                }
            }
        }
    } // body
}

struct SetBirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        SetBirthdayView()
    }
}
