//
//  PlusSetting.swift
//  liveOn
//
//  Created by Keum MinSeok on 2022/06/07.
//

import SwiftUI

struct PlusSetting: View {
    
    @State private var holidaytitle: String = ""
    @State private var holidaymemo: String = ""
    var holidaytitlelimit: Int = 20
    var holidaymemolimit: Int = 20
    @Binding var currentDate: Date
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color("Ivory")
            
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
                
                Button("확인") {
                    
                }
                .font(.title3)
                .foregroundColor(.primary)
                .padding(.top, 15)
                .padding(.leading, 85)
            }
            
            VStack {
                Color.gray.frame(height: CGFloat(1) / UIScreen.main.scale)
                    .padding(.top, 55)
                
                DatePicker("기념일 추가", selection: $currentDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .applyTextColor(Color("Burgundy"))
                    .frame(maxHeight: 400)
                    .padding(.top, -20)
            }
            
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray)
                    .frame(width: 100, height: 100)
                    .padding(.top, 415)
                    .padding(.leading, 20)
                
                Button(action: {
                    
                }) {
                    Text("아이콘 변경")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                .padding(.top, 5)
                .padding(.leading, 21)
            }
            
            VStack {
                TextField("Comment", text: $holidaytitle, prompt: Text("어떤 기념일인가요?"))
                    .limitInputLength(value: $holidaytitle, length: 20)
                    .multilineTextAlignment(TextAlignment.leading)
                    .foregroundColor(.bodyTextColor)
                    .frame(width: 250, height: 20)
                    .font(.system(size: 18))
                    .padding(.top, 420)
                    .padding(.leading, 130)
                
                VStack {
                    Text("(\(holidaytitle.count)/20)")
                        .frame(width: 300, height: 20, alignment: .trailing)
                        .foregroundColor(.bodyTextColor).opacity(0.5)
                    .padding(.trailing, -82)
                    .padding(.top, -8)
                }
                
                TextField("Comment", text: $holidaymemo, prompt: Text("메모를 입력해주세요."))
                    .limitInputLength(value: $holidaymemo, length: 20)
                    .multilineTextAlignment(TextAlignment.leading)
                    .foregroundColor(.bodyTextColor)
                    .frame(width: 250, height: 20)
                    .font(.system(size: 18))
                    .padding(.top, 8)
                    .padding(.leading, 130)
            
                VStack {
                    Text("(\(holidaymemo.count)/20)")
                        .frame(width: 300, height: 20, alignment: .trailing)
                        .foregroundColor(.bodyTextColor).opacity(0.5)
                    .padding(.trailing, -82)
                    .padding(.top, -8)
                }
            }
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
