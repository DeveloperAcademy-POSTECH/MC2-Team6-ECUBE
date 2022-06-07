//
//  CalendarBack.swift
//  liveOn
//
//  Created by Keum MinSeok on 2022/06/07.
//

import SwiftUI

struct CalendarBack: View {
    
    @State var currentDate: Date = Date()
    
    // 색상 변경할려면 이거 참고해서 여기에 추가하기
    @State private var bgColor = Color("Ivory")
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 20) {
                
                // Custom Date Picker // 색상 변경할려면 이거 참고해서 여기에 추가하기
                CalendarMain(currentDate: $currentDate,
                                 bgColor: $bgColor)
            }
            .padding(.vertical)
            .background(bgColor)
        }
        .background(bgColor)
        
        // Safe Area Status Bar
        .overlay(alignment: .top, content: {
            Color.white
                .background(.ultraThinMaterial)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 0)
        })
    }
}

struct CalendarBack_Previews: PreviewProvider {
    static var previews: some View {
        CalendarBack()
    }
}
