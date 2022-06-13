//
//  MoveDateButton.swift
//  liveOn
//
//  Created by Keum MinSeok on 2022/06/13.
//

import SwiftUI

struct MoveDateButton: View {
    
    var autoDate: Date
    
    @Binding var currentDate: Date
    @Binding var showDatePicker: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                DatePicker("Test", selection: $currentDate, displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                Color.gray.frame(height: CGFloat(1) / UIScreen.main.scale)
                    .padding(.top, -20)

                HStack {
                    Button(action: {
                        showDatePicker = false
                    }, label: {
                        Text("취소")
                            .font(.system(size: 18))
                            .foregroundColor(.blue)
                            .padding(.top, -10)
                    })
                    
                    Spacer()
                    
                    Button("이동") {
                        self.currentDate = autoDate
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.system(size: 18))
                    .foregroundColor(.blue)
                    .padding(.top, -10)
                }
                .padding(.horizontal)
            }
            .padding()
            .background(
                Color.white
                    .cornerRadius(30)
            )
        }
    }
}
