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

    var body: some View {
        OnboardingHeader(title: "\(currentUser.nickname)님 환영합니다! \n 생일을 알려주세요 :)", description: "기념일로 등록해둘게요!", inputView:
                                AnyView(
                                    VStack {
                                        Text("\(DateToStringKR(birthday))").font(.title2)
                                            .padding()
                                        // TODO: 캘린더 피커 수정하기
                DatePicker("생일 선택", selection: $birthday, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .background(.clear)
                    .applyTextColor(.bodyTextColor)
                    .padding()
                                        Spacer()
                                    })
            )
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SetFirstDayView().environmentObject(currentUser)) {
                    Text("다음")
                }
                .buttonStyle(.plain)
                
                // MARK: User 데이터 저장
                .simultaneousGesture(TapGesture().onEnded {
                    currentUser.birth = birthday
                })
            }
        }
    } // body
}

struct SetBirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SetBirthdayView()
                .environmentObject(User())
        }
    }
}
