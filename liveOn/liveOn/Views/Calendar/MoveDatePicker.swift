//  MoveDateButton.swift
//  liveOn
//
//  Created by Keum MinSeok on 2022/06/13.

import SwiftUI

struct MoveDatePicker: View {
    
    @State var autoDate: Date = Date()
    
    @Binding var currentDate: Date
    @Binding var showDatePicker: Bool
    @Binding var popUpBoolean: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            VStack {
                DatePicker("Test", selection: $autoDate, displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .applyTextColor(Color("Burgundy"))
                
                Color.gray.frame(height: CGFloat(1) / UIScreen.main.scale)
                    .padding(.top, -20)
                
                HStack {
                    Button(action: {
                        showDatePicker = false
                    }, label: {
                        Text("취소")
                            .font(.system(size: 18))
                            .foregroundColor(.blue)
                            .padding(.top, -16)
                    })
                    
                    Spacer()
                    
                    Button("이동") {
                        self.currentDate = autoDate
                        presentationMode.wrappedValue.dismiss()
                        showDatePicker = false
                    }
                    .font(.system(size: 18))
                    .foregroundColor(.blue)
                    .padding(.top, -16)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
            .background(
                Color.white
                    .cornerRadius(30))
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.36, alignment: .center)
        .offset(x: 0, y: -87)
    }
}
