//
//  PlusSetting.swift
//  liveOn
//
//  Created by Keum MinSeok on 2022/06/07.
//

import SwiftUI

struct PlusSetting: View {
    
    @Binding var currentDate: Date
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color("Ivory")
                .edgesIgnoringSafeArea(.bottom)
            
            HStack {
                Button("취소") {
                    dismiss()
                }
                .font(.title3)
                .foregroundColor(.primary)
                .padding(.top, 15)
                .padding(.leading, 15)
                
                Text("기념일 추가")
                    .font(.title2.bold())
                    .foregroundColor(Color("Burgundy"))
                    .padding(.top, 14)
                    .padding(.leading, 90)
            }
            
            VStack {
            DatePicker("기념일 추가", selection: $currentDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .applyTextColor(Color("Burgundy"))
                    .frame(maxHeight: 400)
            }
            .padding(.top, 30)
        }
    }
}

extension View {
  @ViewBuilder func applyTextColor(_ color: Color) -> some View {
    if UITraitCollection.current.userInterfaceStyle == .light {
      self.colorInvert().colorMultiply(color)
    } else {
      self.colorMultiply(color)
    }
  }
}

struct PlusSetting_Previews: PreviewProvider {
    static var previews: some View {
        CalendarBack()
    }
}
