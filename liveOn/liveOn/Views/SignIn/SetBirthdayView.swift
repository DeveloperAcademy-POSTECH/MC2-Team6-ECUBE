//
//  SetBirthdayView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/08.
//

import SwiftUI

struct SetBirthdayView: View {
    @EnvironmentObject var currentUser: User
    @Environment(\.dismiss) private var dismiss
    @State var birthday: Date = Date.now
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            OnboardingHeader(title: "생일 입력하기", description: " 기념일로 등록해둘게요.", inputView:
                                AnyView(
                                    VStack {
                                        
                                        // 생일을 String으로 표기해주는 캡슐 블럭
                                        Text("\(DateToStringKR(birthday))").font(.title2)
                                            .padding(.vertical, 12)
                                            .padding(.horizontal, 24)
                                            .foregroundColor(.accentColor)
                                            .background(Capsule().fill(Color.accentColor).opacity(0.32))
                                            .offset(y: -32)
                                        
                                        // TODO: 캘린더 피커 수정하기
                                        DatePicker("생일 선택", selection: $birthday, in: ...Date(), displayedComponents: .date)
                                            .datePickerStyle(GraphicalDatePickerStyle())
                                            .applyTextColor(Color.accentColor)
                                            .padding(12)
                                            .background(RoundedRectangle(cornerRadius: 20).fill(Color(uiColor: .systemBackground)).shadow(color: .bodyTextColor.opacity(0.3), radius: 6, x: 0, y: 2))
                                    })
            )
        }
        .navigationToBack(dismiss)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.background)
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
