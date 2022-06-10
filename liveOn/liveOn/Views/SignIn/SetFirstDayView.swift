//
//  SetFirstDayView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/08.
//

import SwiftUI

struct SetFirstDayView: View {
    @EnvironmentObject var currentUser: User
    @State var firstDay: Date = Date.now

    var body: some View {
        OnboardingHeader(title: " 처음 만난날이 언제인가요? ", description: "며칠짼지 세어드릴게요!", inputView:
                                AnyView(
                                    VStack {
                                        Text("\(DateToStringKR(firstDay))").font(.title2)
                                            .padding()
                                        // TODO: 캘린더 피커 수정하기
                DatePicker("1일 선택", selection: $firstDay, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .background(.clear)
                    .applyTextColor(.bodyTextColor)
                    .padding()
                                        Spacer()
                                    })
            )
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SelectWhatToDoView().environmentObject(currentUser)) {
                    Text("다음")
                }
                .buttonStyle(.plain)
                
                // MARK: User 데이터 저장
                .simultaneousGesture(TapGesture().onEnded {
                    currentUser.firstDay = firstDay
                })
            }
        }
    } // body
}

struct SetFirstDayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SetFirstDayView()
                .environmentObject(User())
        }
    }
}
