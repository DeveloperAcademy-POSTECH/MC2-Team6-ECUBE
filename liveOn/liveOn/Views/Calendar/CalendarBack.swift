//
//  CalendarBack.swift
//  liveOn
//
//  Created by Keum MinSeok on 2022/06/07.
//

import SwiftUI

struct CalendarBack: View {
    
    @State var currentDate: Date = Date()
    @State private var bgColor = Color("background")
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 20) {
                CalendarMain(currentDate: $currentDate,
                                 bgColor: $bgColor)
            }
            .padding(.vertical)
            .background(bgColor)
        }
        .background(bgColor)
        
        // Safe Area Status Bar
//        .overlay(alignment: .top, content: {
//            Color("backgournd")
//                .background(.ultraThinMaterial)
//                .edgesIgnoringSafeArea(.top)
//                .frame(height: 0)
//        })
    }
}

struct CalendarBack_Previews: PreviewProvider {
    static var previews: some View {
        CalendarBack()
    }
}
