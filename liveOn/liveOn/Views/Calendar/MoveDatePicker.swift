//  MoveDatePicker.swift
//  liveOn
//
//  Created by Keum MinSeok on 2022/06/13.

import SwiftUI

struct MoveDatePicker: View {
    
    @State var autoDate: Date = Date()
    
    @Binding var currentDate: Date
    @Binding var showDatePicker: Bool
    @Binding var popUpBoolean: Bool
    @Binding var isClicked: Bool
    @Binding var burgundyColor: Color

    var body: some View {
        ZStack {
            VStack {
                DatePicker("Test", selection: $autoDate, displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .accentColor(.black)
                    .applyTextColor(burgundyColor)
                                
                HStack {
                    Button("취소") {
                        showDatePicker = false
                        isClicked.toggle()
                    }
                    .font(.system(size: 18).bold())
                    .foregroundColor(burgundyColor)
                    .padding(.top, -16)
                    
                    Spacer()
                    
                    Button("확인") {
                        self.currentDate = autoDate
                        showDatePicker = false
                        isClicked.toggle()
                    }
                    .font(.system(size: 18).bold())
                    .foregroundColor(burgundyColor)
                    .padding(.top, -16)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
            .background(Color.white.cornerRadius(30))
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.36, alignment: .center)
        .padding(.bottom, 235)
    }
}
